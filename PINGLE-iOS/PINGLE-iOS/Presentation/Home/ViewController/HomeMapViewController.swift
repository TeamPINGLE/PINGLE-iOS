//
//  HomeMapViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/1/24.
//

import UIKit

import SafariServices
import CoreLocation
import NMapsMap
import SnapKit
import Then

final class HomeMapViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    var shouldUpdateMap: Bool = true
    var homePinDetailList: [HomePinDetailResponseDTO] = []
    var meetingId: [Int] = []
    var markerId = 0
    var markerCategory: String = ""
    var allowLocation = false
    var currentMeetingId: Int = 0
    
    // MARK: Component
    let mapsView = HomeMapView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        setAddTarget()
        setCollectionView()
        self.loadPinList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        self.view.addSubviews(mapsView)
        
        mapsView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
    }
    
    override func setDelegate() {
        self.mapsView.mapsView.mapView.touchDelegate = self
        self.mapsView.homeDetailCollectionView.delegate = self
        self.mapsView.homeDetailCollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        self.mapsView.homeDetailCollectionView.register(HomeDetailCollectionViewCell.self, forCellWithReuseIdentifier: HomeDetailCollectionViewCell.identifier)
    }
    
    private func setLocationManager() {
        mapsView.locationManager.delegate = self
        mapsView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapsView.locationManager.requestWhenInUseAuthorization()
        self.startUpdatingLocationAndMoveToCurrentLocation()
    }
    
    private func setAddTarget() {
        self.mapsView.chipButtons.forEach {
            $0.addTarget(self, action: #selector(isChipButtonTapped), for: .touchUpInside)
        }
        self.mapsView.currentLocationButton.addTarget(self,
                                                      action: #selector(currentLocationButtonTapped),
                                                      for: .touchUpInside)
    }
}

// MARK: - extension
// MARK: CLLocationManagerDelegate
extension HomeMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            mapsView.nowLat = location.coordinate.latitude
            mapsView.nowLng = location.coordinate.longitude
            
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
            
            if shouldUpdateMap {
                moveToCurrentLocation()
                shouldUpdateMap = false
                allowLocation = true
            }
            self.mapsView.setCurrentMarker()
        }
    }
    
    // 위치 가져오기 실패 시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // 위치 권한이 허용된 경우
            print("위치 권한이 허용되었습니다.")
            startUpdatingLocationAndMoveToCurrentLocation()
            self.moveToCurrentLocation()
            self.allowLocation = true
        case .denied, .restricted:
            // 위치 권한이 거부된 경우
            print("위치 권한이 거부되었습니다.")
            self.allowLocation = false
        case .notDetermined:
            // 위치 권한이 아직 결정되지 않은 경우
            print("위치 권한이 아직 결정되지 않았습니다.")
            manager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("Unhandled authorization status")
        }
    }
    
    private func startUpdatingLocationAndMoveToCurrentLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.mapsView.locationManager.startUpdatingLocation()
            } else {
                print("위치 서비스 허용 off")
            }
        }
    }
}

// MARK: NMFMapViewTouchDelegate
extension HomeMapViewController: NMFMapViewTouchDelegate {
    /// 지도 탭 되었을 때 메소드
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        self.hideSelectedPin()
    }
}

// MARK: UICollectionViewDelegate
extension HomeMapViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource
extension HomeMapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePinDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDetailCollectionViewCell.identifier, for: indexPath) as? HomeDetailCollectionViewCell else { return UICollectionViewCell() }
        cell.mapDetailView.dataBind(data: homePinDetailList[indexPath.row])
        cell.mapDetailView.updateStyle()
        
        cell.mapDetailView.participantsButtonAction = {
            cell.showPopUp(isParticipating: self.homePinDetailList[indexPath.row].isParticipating, isOwner: cell.mapDetailView.isOwner)
        }
        
        cell.mapDetailView.talkButtonAction = {
            self.connectTalkLink(urlString: self.homePinDetailList[indexPath.row].chatLink)
        }
        
        cell.homeDetailPopUpView.participantionButtonAction = {
            self.meetingJoin(meetingId: self.homePinDetailList[indexPath.row].id) { [weak self] result in
                guard let self else { return }
                if result {
                    print("참여하기 버튼 탭")
                    cell.mapDetailView.isParticipating = true
                    self.bindDetailViewData(id: self.markerId, category: self.markerCategory) {}
                }
            }
        }
        
        cell.homeDetailCancelPopUpView.cancelButtonAction = {
            if cell.mapDetailView.isOwner {
                self.meetingDelete(meetingId: self.homePinDetailList[indexPath.row].id) { [weak self] result in
                    guard let self else { return }
                    if result {
                        print("삭제하기 버튼 탭")
                        self.bindDetailViewData(id: self.markerId, category: self.markerCategory) {}
                        self.mapsView.homeDetailCollectionView.isHidden = true
                        self.loadPinList()
                    }
                }
            } else {
                self.meetingCancel(meetingId: self.homePinDetailList[indexPath.row].id) { [weak self] result in
                    guard let self else { return }
                    if result {
                        print("취소하기 버튼 탭")
                        cell.mapDetailView.isParticipating = false
                        self.bindDetailViewData(id: self.markerId, category: self.markerCategory) {}
                    }
                }
            }
        }
        
        cell.homeDetailPopUpView.dataBind(data: self.homePinDetailList[indexPath.row])
        
        cell.memberButtonAction = {
            self.currentMeetingId = cell.mapDetailView.meetingId
            self.participantCountButtonTapped()
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeMapViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = (UIScreen.main.bounds.width - 48.adjustedWidth) + 8.adjustedWidth
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

extension HomeMapViewController {
    
    func hideSelectedPin() {
        if !self.mapsView.homeDetailCollectionView.isHidden {
            self.mapsView.homeDetailCollectionView.isHidden = true
            self.mapsView.currentLocationButton.isHidden = false
            self.mapsView.listButton.isHidden = false
            self.mapsView.homeMarkerList.forEach {
                $0.iconImage = NMFOverlayImage(image: self.mapsView.setMarkerColor(category: $0.meetingString))
            }
        }
    }
    
    /// 카메라를 이동하는 메소드
    func moveToCurrentLocation() {
        self.mapsView.cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: mapsView.nowLat, lng: mapsView.nowLng))
        self.mapsView.cameraUpdate.animation = .easeIn
        self.mapsView.mapsView.mapView.moveCamera(mapsView.cameraUpdate)
    }
    
    // MARK: Objc Function
    @objc func isChipButtonTapped(sender: ChipButton) {
        /// 태그 선택 여부 반전
        sender.isButtonSelected.toggle()
        
        /// 서버 통신
        if sender.isButtonSelected {
            self.pinList(category: sender.chipStatusString) { [weak self] result in
                guard let self else { return }
                if result {
                    self.setMarker()
                }
            }
            self.markerCategory = sender.chipStatusString
        } else {
            self.pinList(category: "") { [weak self] result in
                guard let self else { return }
                if result {
                    self.setMarker()
                }
            }
            self.markerCategory = ""
        }
        
        /// 태그 하나만 선택할 수 있도록
        self.mapsView.chipButtons.filter { $0 != sender }.forEach {
            $0.isButtonSelected = false
        }
        
        /// 모든 마커 (핀) 다 보이도록
        self.mapsView.homeMarkerList.forEach {
            $0.hidden = false
        }
        
        self.hideSelectedPin()
    }
    
    @objc func currentLocationButtonTapped() {
        if allowLocation {
            moveToCurrentLocation()
        }
    }
    
    func participantCountButtonTapped() {
        print("참여현황")
        let participantsListViewController = ParticipantsListViewController()
        participantsListViewController.meetingIdentifier = self.currentMeetingId
        self.navigationController?.pushViewController(participantsListViewController, animated: true)
    }
    
    func connectTalkLink(urlString: String) {
        print("대화하기 버튼 탭")
        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }
        
        if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            guard let chatURL = URL(string: "https://" + urlString) else {
                print("chatURL error")
                return
            }
            UIApplication.shared.open(chatURL, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: Custom Function
    /// 마커에 핸들러 부여
    func setMarkerHandler() {
        self.mapsView.homeDetailCollectionView.isHidden = true
        
        self.mapsView.homeMarkerList.forEach { marker in
            marker.touchHandler = { ( _: NMFOverlay) -> Bool in
                print("오버레이 터치됨")
                let category = self.markerCategory.isEmpty ? "" : marker.meetingString
                self.bindDetailViewData(id: marker.id, category: category) {
                    /// 맨 처음 인덱스로 돌아오도록 스크롤
                    if !self.homePinDetailList.isEmpty {
                        let indexPath = IndexPath(item: 0, section: 0)
                        self.mapsView.homeDetailCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
                    }
                }
                self.mapsView.currentLocationButton.isHidden = true
                self.mapsView.listButton.isHidden = true
                self.markerTapped(marker: marker)
                self.markerId = marker.id
                return true
            }
        }
    }
    
    func bindDetailViewData(id: Int, category: String?, completion: @escaping () -> Void) {
        // 추후 바뀐 그룹 받아오는 로직 작성 예정
        self.pinDetail(pinId: id, category: category) { [weak self] result in
            guard let self else { return }
            if result {
                self.mapsView.homeDetailCollectionView.reloadData()
                self.mapsView.homeDetailCollectionView.isHidden = false
            }
            completion()
        }
    }
    
    func markerTapped(marker: PINGLEMarker) {
        self.mapsView.homeMarkerList.forEach {
            $0.iconImage = NMFOverlayImage(image: self.mapsView.setMarkerColor(category: $0.meetingString))
        }
        
        var activateImage: UIImage = UIImage(resource: .imgMapPinOtherActive)
        switch marker.meetingStatus {
        case .play:
            activateImage = UIImage(resource: .imgMapPinPlayActive)
        case .study:
            activateImage = UIImage(resource: .imgMapPinStudyActive)
        case .multi:
            activateImage = UIImage(resource: .imgMapPinMultiActive)
        default:
            activateImage = UIImage(resource: .imgMapPinOtherActive)
        }
        
        marker.iconImage = NMFOverlayImage(image: activateImage)
        /// zoomLevel에 따라서 일정한 위치로 카메라 이동할 수 있도록 계산
        let offsetLat = marker.position.lat - 0.003 * pow(2, 14 - self.mapsView.mapsView.mapView.zoomLevel)
        
        let newCameraPosition = NMFCameraPosition(NMGLatLng(lat: offsetLat, lng: marker.position.lng),
                                                  zoom: self.mapsView.mapsView.mapView.zoomLevel,
                                                  tilt: 0,
                                                  heading: 0)
        
        let newCameraUpdate = NMFCameraUpdate(position: newCameraPosition)
        newCameraUpdate.animation = .easeIn
        self.mapsView.mapsView.mapView.moveCamera(newCameraUpdate)
    }
    
    // MARK: Server Function
    func pinList(category: String?, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.homeService.pinList(teamId: KeychainHandler.shared.userGroup[0].id, queryDTO: HomePinListRequestQueryDTO(category: category)) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                print(data)
                self?.mapsView.homePinList = data
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    func loadPinList() {
        self.pinList(category: self.markerCategory) {_ in
            self.setMarker()
        }
    }
    
    func pinDetail(pinId: Int, category: String?, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.homeService.pinDetail(pinId: pinId, teamId: KeychainHandler.shared.userGroup[0].id, queryDTO: HomePinListRequestQueryDTO(category: category)) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                print(data)
                DispatchQueue.main.async { [weak self] in
                    self?.homePinDetailList = []
                    self?.homePinDetailList = data
                    data.forEach {
                        self?.meetingId.append($0.id)
                    }
                    completion(true)
                }
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    func meetingJoin(meetingId: Int, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.homeService.meetingJoin(meetingId: meetingId) { response in
            switch response {
            case .success:
                print("신청 완료")
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    func meetingCancel(meetingId: Int, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.homeService.meetingCancel(meetingId: meetingId) { response in
            switch response {
            case .success:
                print("신청 취소 완료")
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    func meetingDelete(meetingId: Int, completion: @escaping (Bool) -> Void) {
        NetworkService.shared.homeService.meetingDelete(meetingId: meetingId) { response in
            switch response {
            case .success:
                print("신청 취소 완료")
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    // MARK: Marker Function
    /// 마커 추가 메소드
    func setMarker() {
        /// 마커 다 지우기
        self.mapsView.homeMarkerList.forEach {
            $0.hidden = true
        }
        mapsView.homeMarkerList = []
        
        mapsView.homePinList.forEach {
            let pingleMarker = PINGLEMarker()
            
            pingleMarker.id = $0.id
            pingleMarker.changeStringToStatus(string: $0.category)
            pingleMarker.meetingString = $0.category
            
            let x = $0.x
            let y = $0.y
            
            pingleMarker.iconImage = NMFOverlayImage(image: mapsView.setMarkerColor(category: $0.category))
            
            pingleMarker.position = NMGLatLng(lat: y, lng: x)
            pingleMarker.mapView = mapsView.mapsView.mapView
            mapsView.homeMarkerList.append(pingleMarker)
        }
        self.setMarkerHandler()
    }
}

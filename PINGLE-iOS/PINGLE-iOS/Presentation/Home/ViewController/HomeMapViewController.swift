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
    private var shouldUpdateMap: Bool = true
    var homePinList: [HomePinListResponseDTO] = []
    var homePinDetailList: [HomePinDetailResponseDTO] = []
    private var meetingId: [Int] = []
    private var markerId = 0
    var markerCategory: String = ""
    var searchText: String = ""
    private var allowLocation = false
    private var isFirstSearch = true
    var currentMeetingId: Int = 0
    var participantsAction: (() -> Void) = {}
    var updateIsHomeMapAction: (() -> Void) = {}
    var isSearchResult = false
    
    // MARK: Component
    let mapsView = HomeMapView()
    let alreadyToastView = PINGLEWarningToastView()

    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        setAddTarget()
        setCollectionView()
        loadPinList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        alreadyToastView.do {
            $0.alpha = 0.0
            $0.backgroundColor = .grayscaleG02
            $0.warningImageView.image = UIImage(resource: .icInfoBlack)
            $0.warningLabel.textColor = .black
        }
    }
    
    override func setLayout() {
        view.addSubviews(mapsView,
                         alreadyToastView)
        
        mapsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alreadyToastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    override func setDelegate() {
        mapsView.mapsView.mapView.touchDelegate = self
        mapsView.homeDetailCollectionView.delegate = self
        mapsView.homeDetailCollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        mapsView.homeDetailCollectionView.register(
            HomeDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeDetailCollectionViewCell.identifier
        )
    }
    
    private func setLocationManager() {
        mapsView.locationManager.delegate = self
        mapsView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapsView.locationManager.requestWhenInUseAuthorization()
        startUpdatingLocationAndMoveToCurrentLocation()
    }
    
    private func setAddTarget() {
        mapsView.currentLocationButton.addTarget(
            self,
            action: #selector(currentLocationButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - extension
// MARK: CLLocationManagerDelegate
extension HomeMapViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
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
            mapsView.setCurrentMarker()
        }
    }
    
    // 위치 가져오기 실패 시
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("위치 권한이 허용되었습니다.")
            startUpdatingLocationAndMoveToCurrentLocation()
            moveToCurrentLocation()
            allowLocation = true
        case .denied, .restricted:
            print("위치 권한이 거부되었습니다.")
            allowLocation = false
        case .notDetermined:
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
    func mapView(
        _ mapView: NMFMapView,
        didTapMap latlng: NMGLatLng,
        point: CGPoint
    ) {
        hideSelectedPin()
    }
}

// MARK: UICollectionViewDelegate
extension HomeMapViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource
extension HomeMapViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return homePinDetailList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeDetailCollectionViewCell.identifier,
            for: indexPath) as? HomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.mapDetailView.dataBind(data: homePinDetailList[indexPath.row])
        cell.mapDetailView.updateStyle()
        
        cell.mapDetailView.participantsButtonAction = {
            cell.showPopUp(
                isParticipating: self.homePinDetailList[indexPath.row].isParticipating,
                isOwner: cell.mapDetailView.isOwner
            )
        }
        
        cell.mapDetailView.talkButtonAction = {
            self.connectTalkLink(urlString: self.homePinDetailList[indexPath.row].chatLink)
            AmplitudeInstance.shared.track(eventType: .clickPinChat)
        }
        
        cell.homeDetailPopUpView.participantionButtonAction = {
            self.meetingJoin(meetingId: self.homePinDetailList[indexPath.row].id) { [weak self] result in
                guard let self else { return }
                if result {
                    cell.mapDetailView.isParticipating = true
                }
                bindDetailViewData(
                    id: markerId,
                    category: markerCategory,
                    q: searchText
                ) {}
                AmplitudeInstance.shared.track(eventType: .clickPinParticipate)
            }
            if self.isSearchResult {
                NotificationCenter.default.post(
                    name: .updatePinAndList,
                    object: nil,
                    userInfo: nil)
            }
        }
        
        cell.homeDetailCancelPopUpView.cancelButtonAction = {
            if cell.mapDetailView.isOwner {
                self.meetingDelete(meetingId: self.homePinDetailList[indexPath.row].id) { [weak self] result in
                    guard let self else { return }
                    if result {
                        bindDetailViewData(
                            id: markerId,
                            category: markerCategory,
                            q: searchText
                        ) {}
                        mapsView.homeDetailCollectionView.isHidden = true
                        loadPinList()
                    }
                }
                AmplitudeInstance.shared.track(eventType: .clickPinDelete)
            } else {
                self.meetingCancel(meetingId: self.homePinDetailList[indexPath.row].id) { [weak self] result in
                    guard let self else { return }
                    if result {
                        cell.mapDetailView.isParticipating = false
                        bindDetailViewData(
                            id: markerId,
                            category: markerCategory,
                            q: searchText
                        ) {}
                    }
                }
                AmplitudeInstance.shared.track(eventType: .clickPinCancel)
            }
            if self.isSearchResult {
                NotificationCenter.default.post(
                    name: .updatePinAndList,
                    object: nil,
                    userInfo: nil)
            }
        }
        
        cell.homeDetailPopUpView.dataBind(data: homePinDetailList[indexPath.row])
        
        cell.memberButtonAction = {
            self.currentMeetingId = cell.mapDetailView.meetingId
            self.participantCountButtonTapped()
            AmplitudeInstance.shared.track(eventType: .clickPinParticipants)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeMapViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = (UIScreen.main.bounds.width - 48.adjustedWidth) + 8.adjustedWidth
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(
            x: index * cellWidth - scrollView.contentInset.left,
            y: scrollView.contentInset.top
        )
    }
}

extension HomeMapViewController {
    
    func hideSelectedPin() {
        if !mapsView.homeDetailCollectionView.isHidden {
            mapsView.homeDetailCollectionView.isHidden = true
            mapsView.currentLocationButton.isHidden = false
            mapsView.listButton.isHidden = false
            mapsView.homeMarkerList.forEach {
                $0.iconImage = NMFOverlayImage(image: mapsView.setMarkerColor(category: $0.meetingString))
            }
        }
    }
    
    /// 카메라를 이동하는 메소드
    private func moveToCurrentLocation() {
        mapsView.cameraUpdate = NMFCameraUpdate(
            scrollTo: NMGLatLng(
                lat: mapsView.nowLat,
                lng: mapsView.nowLng
            )
        )
        mapsView.cameraUpdate.animation = .easeIn
        mapsView.mapsView.mapView.moveCamera(mapsView.cameraUpdate)
    }
    
    // MARK: Objc Function
    @objc private func currentLocationButtonTapped() {
        if allowLocation {
            moveToCurrentLocation()
        }
        AmplitudeInstance.shared.track(eventType: .clickCurrentlocation)
    }
    
    private func participantCountButtonTapped() {
        participantsAction()
    }
    
    private func connectTalkLink(urlString: String) {
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
    private func setMarkerHandler() {
        mapsView.homeDetailCollectionView.isHidden = true
        
        mapsView.homeMarkerList.forEach { marker in
            marker.touchHandler = { ( _: NMFOverlay) -> Bool in
                let category = self.markerCategory.isEmpty ? "" : marker.meetingString
                let searchText = self.searchText
                self.bindDetailViewData(
                    id: marker.id,
                    category: category,
                    q: searchText
                ) {
                    /// 맨 처음 인덱스로 돌아오도록 스크롤
                    if !self.homePinDetailList.isEmpty {
                        let indexPath = IndexPath(item: 0, section: 0)
                        self.mapsView.homeDetailCollectionView.scrollToItem(
                            at: indexPath,
                            at: .left,
                            animated: false)
                    }
                }
                self.mapsView.currentLocationButton.isHidden = true
                self.mapsView.listButton.isHidden = true
                self.markerTapped(marker: marker)
                self.markerId = marker.id
                AmplitudeInstance.shared.track(eventType: .clickPinMap)
                return true
            }
        }
    }
    
    private func bindDetailViewData(
        id: Int,
        category: String,
        q: String,
        completion: @escaping () -> Void
    ) {
        pinDetail(pinId: id, category: category, q: q) { [weak self] result in
            guard let self else { return }
            if result {
                mapsView.homeDetailCollectionView.reloadData()
                mapsView.homeDetailCollectionView.isHidden = false
            }
            completion()
        }
    }
    
    private func markerTapped(marker: PINGLEMarker) {
        mapsView.homeMarkerList.forEach {
            $0.iconImage = NMFOverlayImage(image: mapsView.setMarkerColor(category: $0.meetingString))
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
        let offsetLat = marker.position.lat - 0.003 * pow(2, 14 - mapsView.mapsView.mapView.zoomLevel)
        
        let newCameraPosition = NMFCameraPosition(
            NMGLatLng(lat: offsetLat, lng: marker.position.lng),
            zoom: mapsView.mapsView.mapView.zoomLevel,
            tilt: 0,
            heading: 0
        )
        
        let newCameraUpdate = NMFCameraUpdate(position: newCameraPosition)
        newCameraUpdate.animation = .easeIn
        mapsView.mapsView.mapView.moveCamera(newCameraUpdate)
    }
    
    // MARK: Server Function
    func pinList(
        category: String,
        q: String,
        completion: @escaping (Bool) -> Void
    ) {
        /// isSearchResult가 true이고, 공백문자 입력시 처리
        if isSearchResult && q.trimmingCharacters(in: .whitespaces).isEmpty {
            DispatchQueue.main.async { [weak self] in
                self?.updateIsHomeMapAction()
            }
            completion(false)
            return
        }
        
        if let userGroupId = KeychainHandler.shared.userGroupId {
            NetworkService.shared.homeService.pinList(
                teamId: userGroupId,
                queryDTO: HomePinListRequestQueryDTO(category: category.isEmpty ? nil : category, q: q.isEmpty ? nil : q)
            ) { [weak self] response in
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    if data.isEmpty && !q.isEmpty && (self?.isFirstSearch ?? true) {
                        self?.updateIsHomeMapAction()
                    }
                    print(data)
                    self?.mapsView.homePinList = data
                    if !q.isEmpty && !data.isEmpty && (self?.isFirstSearch ?? true) {
                        self?.searchCameraMove(
                            x: data[0].x,
                            y: data[0].y)
                        self?.isFirstSearch.toggle()
                    }
                    completion(true)
                default:
                    print("실패")
                    completion(false)
                    return
                }
            }
        }
    }
    
    func loadPinList() {
        pinList(category: markerCategory, q: searchText) {_ in
            self.setMarker()
        }
    }
    
    private func pinDetail(
        pinId: Int,
        category: String,
        q: String,
        completion: @escaping (Bool) -> Void
    ) {
        if let userGroupId = KeychainHandler.shared.userGroupId {
            NetworkService.shared.homeService.pinDetail(
                pinId: pinId,
                teamId: userGroupId,
                queryDTO: HomePinListRequestQueryDTO(category: category.isEmpty ? nil : category, q: q.isEmpty ? nil : q)
            ) { [weak self] response in
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
    }
    
    private func meetingJoin(
        meetingId: Int,
        completion: @escaping (Bool) -> Void
    ) {
        NetworkService.shared.homeService.meetingJoin(meetingId: meetingId) { response in
            switch response {
            case .success(let data):
                if data.code == 201 {
                    print("신청 완료")
                    completion(true)
                } else if data.code == 409 {
                    self.alreadyToastView.warningLabel.text =  StringLiterals.ToastView.alreadyMeeting
                    self.alreadyToastView.fadeIn()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.alreadyToastView.fadeOut()
                    }
                    completion(false)
                } else if data.code == 404 && data.message == StringLiterals.ErrorMessage.notFoundMeeting {
                    self.meetingNotFound()
                }
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    private func meetingCancel(
        meetingId: Int,
        completion: @escaping (Bool) -> Void
    ) {
        NetworkService.shared.homeService.meetingCancel(meetingId: meetingId) { response in
            switch response {
            case .success(let data):
                if data.code == 200 {
                    print("취소 완료")
                    completion(true)
                } else if data.code == 404 && data.message == StringLiterals.ErrorMessage.notFoundMember {
                    self.meetingNotFound()
                }
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    private func meetingDelete(
        meetingId: Int,
        completion: @escaping (Bool) -> Void
    ) {
        NetworkService.shared.homeService.meetingDelete(meetingId: meetingId) { response in
            switch response {
            case .success:
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    private func meetingNotFound() {
        self.alreadyToastView.warningLabel.text =  StringLiterals.ToastView.deleteMeeting
        self.alreadyToastView.fadeIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.alreadyToastView.fadeOut()
        }
        self.loadPinList()
        self.hideSelectedPin()
    }
    
    // MARK: Marker Function
    /// 마커 추가 메소드
    func setMarker() {
        /// 마커 다 지우기
        mapsView.homeMarkerList.forEach {
            $0.hidden = true
        }
        mapsView.homeMarkerList = []
        mapsView.homeMarkerList = mapsView.homePinList.map { pin -> PINGLEMarker in
            let pingleMarker = PINGLEMarker()
            
            pingleMarker.id = pin.id
            pingleMarker.changeStringToStatus(string: pin.category)
            pingleMarker.meetingString = pin.category
            
            pingleMarker.iconImage = NMFOverlayImage(image: mapsView.setMarkerColor(category: pin.category))
            pingleMarker.position = NMGLatLng(
                lat: pin.y,
                lng: pin.x
            )
            
            pingleMarker.mapView = mapsView.mapsView.mapView
            
            return pingleMarker
        }
        setMarkerHandler()
    }
    
    private func searchCameraMove(x: Double, y: Double) {
            mapsView.cameraUpdate = NMFCameraUpdate(
                scrollTo: NMGLatLng(
                    lat: y,
                    lng: x
                )
            )
            mapsView.cameraUpdate.animation = .easeIn
            mapsView.mapsView.mapView.moveCamera(mapsView.cameraUpdate)
    }
}

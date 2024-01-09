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
    /// 현재 선택되지 않은 필터 버튼 개수
    var unselectedButton: Int = 0
    
    // MARK: Component
    let mapsView = HomeMapView()
    let mapDetailView = HomeMapDetailView()
    let dimmedView = UIView()
    let homeDetailPopUpView = HomeDetailPopUpView()
    let homeDetailCancelPopUpView = HomeDetailCancelPopUpView()
    let dimmedTapGesture = UITapGestureRecognizer()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        setAddTarget()
        setMarkerHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        dimmedView.do {
            $0.backgroundColor = .black
            $0.alpha = 0.7
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
        }
        
        homeDetailPopUpView.do {
            $0.isHidden = true
        }
        
        homeDetailCancelPopUpView.do {
            $0.isHidden = true
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        self.view.addSubviews(mapsView,
                              mapDetailView)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviews(dimmedView,
                               homeDetailPopUpView,
                               homeDetailCancelPopUpView)
        }
        
        mapsView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        mapDetailView.snp.makeConstraints {
            $0.bottom.equalTo(mapsView).offset(-8.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(327)
            $0.width.equalTo(327.adjustedWidth)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        homeDetailPopUpView.snp.makeConstraints {
            $0.center.equalTo(dimmedView)
        }
        
        homeDetailCancelPopUpView.snp.makeConstraints {
            $0.center.equalTo(dimmedView)
        }
    }
    
    override func setDelegate() {
        self.mapsView.mapsView.mapView.touchDelegate = self
        self.dimmedTapGesture.delegate = self
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
        self.mapDetailView.participationButton.addTarget(self,
                                                         action: #selector(participantsButtonTapped),
                                                         for: .touchUpInside)
        self.mapDetailView.talkButton.addTarget(self,
                                                action: #selector(talkButtonTapped),
                                                for: .touchUpInside)
        self.dimmedView.addGestureRecognizer(dimmedTapGesture)
        self.homeDetailPopUpView.participationButton.addTarget(self,
                                                               action: #selector(participationButtonTapped),
                                                               for: .touchUpInside)
        self.homeDetailCancelPopUpView.cancelButton.addTarget(self,
                                                              action: #selector(cancelButtonTapped),
                                                              for: .touchUpInside)
        self.homeDetailCancelPopUpView.backButton.addTarget(self,
                                                            action: #selector(backButtonTapped),
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
            }
            self.mapsView.setCurrentMarker()
        }
    }
    
    // 위치 가져오기 실패 시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("error")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // 위치 권한이 허용된 경우
            print("위치 권한이 허용되었습니다.")
            startUpdatingLocationAndMoveToCurrentLocation()
            self.moveToCurrentLocation()
        case .denied, .restricted:
            // 위치 권한이 거부된 경우
            print("위치 권한이 거부되었습니다.")
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
        if !self.mapDetailView.isHidden {
            self.mapDetailView.isHidden = true
            self.mapsView.currentLocationButton.isHidden = false
            self.mapsView.listButton.isHidden = false
            self.mapsView.homeMarkerList.forEach {
                $0.iconImage = NMFOverlayImage(image: self.mapsView.setMarkerColor(category: $0.meetingString))
            }
        }
    }
}

// MARK: UIGestureRecognizerDelegate
extension HomeMapViewController: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        dimmedView.isHidden = true
        homeDetailPopUpView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        return true
    }
}

extension HomeMapViewController {
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
        
        /// 태그 하나만 선택할 수 있도록
        self.mapsView.chipButtons.filter { $0 != sender }.forEach {
            $0.isButtonSelected = false
        }
        
        /// 모든 마커 (핀) 다 보이도록
        self.mapsView.homeMarkerList.forEach {
            $0.hidden = false
        }
        
        unselectedButton = 0
        
        self.mapsView.chipButtons.forEach {
            if !$0.isButtonSelected {
                unselectedButton += 1
            }
        }
        
        /// 아무 필터도 선택되지 않았다면 모두 보여주고, 선택되었다면 필터링해서 보여주기
        if unselectedButton != 4 {
            self.mapsView.homeMarkerList.filter { $0.meetingString != sender.chipStatusString }.forEach {
                $0.hidden = true
            }
        }
    }
    
    @objc func participationButtonTapped() {
        print("참여하기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailPopUpView.isHidden = true
    }
    
    @objc func cancelButtonTapped() {
        print("취소하기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
    }
    
    @objc func backButtonTapped() {
        print("돌아가기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
    }
    
    @objc func currentLocationButtonTapped() {
        moveToCurrentLocation()
    }
    
    @objc func participantsButtonTapped() {
        if !mapDetailView.isParticipating {
            dimmedView.isHidden = false
            homeDetailPopUpView.isHidden = false
        } else {
            dimmedView.isHidden = false
            homeDetailCancelPopUpView.isHidden = false
        }
    }
    
    @objc func talkButtonTapped() {
        print("대화하기 버튼 탭")
        guard let chatURL = mapDetailView.openChatURL else { return }
        guard let url = URL(string: chatURL) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    // MARK: Custom Function
    /// 마커에 핸들러 부여
    func setMarkerHandler() {
        mapDetailView.isHidden = true
        
        self.mapsView.homeMarkerList.forEach { marker in
            marker.touchHandler = { ( _: NMFOverlay) -> Bool in
                print("오버레이 터치됨")
                self.bindDetailViewData(id: marker.id)
                self.mapDetailView.isHidden = false
                self.mapsView.currentLocationButton.isHidden = true
                self.mapsView.listButton.isHidden = true
                self.markerTapped(marker: marker)
                return true
            }
        }
    }
    
    func bindDetailViewData(id: Int) {
        // 해당 id값을 넣어서 서버 통신 후 data 받아오기
        let data = homePinDetailDummy[0]
        self.mapDetailView.dataBind(data: data)
        self.homeDetailPopUpView.dataBind(data: data)
    }
    
    func markerTapped(marker: PINGLEMarker) {
        self.mapsView.homeMarkerList.forEach {
            $0.iconImage = NMFOverlayImage(image: self.mapsView.setMarkerColor(category: $0.meetingString))
        }
        
        // 추후 바뀌는 이미지 등록
        marker.iconImage = NMFOverlayImage(image: ImageLiterals.Home.Map.icLocationOverlay)
        /// zoomLevel에 따라서 일정한 위치로 카메라 이동할 수 있도록 계산
        let offsetLat = marker.position.lat - 0.003 * pow(2, 14 - self.mapsView.mapsView.mapView.zoomLevel)
        let newCameraPosition = NMFCameraUpdate(scrollTo: NMGLatLng(lat: offsetLat, lng: marker.position.lng))
        newCameraPosition.animation = .easeIn
        self.mapsView.mapsView.mapView.moveCamera(newCameraPosition)
    }
}

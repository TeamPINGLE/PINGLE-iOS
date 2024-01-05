//
//  HomeMapView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/2/24.
//

import UIKit

import NMapsMap
import SnapKit
import Then

final class HomeMapView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var nowLat: Double = 37.56299678698725
    var nowLng: Double = 126.8569346126135
    
    // MARK: Component
    let chipStackView = UIStackView()
    
    let playChipButton = ChipButton(state: .play)
    let studyChipButton = ChipButton(state: .study)
    let multiChipButton = ChipButton(state: .multi)
    let othersChipButton = ChipButton(state: .others)
    
    lazy var chipButtons: [ChipButton] = [playChipButton,
                                          studyChipButton,
                                          multiChipButton,
                                          othersChipButton]
    
    let mapsView = NMFNaverMapView()
    
    var locationManager = CLLocationManager()
    lazy var cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.nowLat, lng: self.nowLng))
    
    let currentMarker = NMFMarker()
    
    let currentLocationButton = UIButton()
    let listButton = UIButton()
    
    var homeMarkerList: [PINGLEMarker] = []
    
    // MARK: - Function
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMarker()
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        cameraUpdate.do {
            $0.animation = .easeIn
        }
        
        mapsView.do {
            $0.mapView.positionMode = .normal
            $0.mapView.isNightModeEnabled = true
            $0.mapView.mapType = .navi
            $0.mapView.moveCamera(cameraUpdate)
            $0.showScaleBar = false
            $0.showZoomControls = false
            $0.showCompass = false
            $0.showLocationButton = false
            $0.mapView.locationOverlay.hidden = true
        }
        
        cameraUpdate.do {
            $0.animation = .easeIn
        }
        
        chipStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4.adjustedWidth
        }
        
        currentLocationButton.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 25.adjusted)
            $0.setImage(ImageLiterals.Home.Map.icMapHere, for: .normal)
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
        
        listButton.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 25.adjusted)
            $0.setImage(ImageLiterals.Home.Map.icMapList, for: .normal)
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
        
        currentMarker.do {
            $0.iconImage = NMFOverlayImage(image: ImageLiterals.Home.Map.icLocationOverlay)
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(mapsView, chipStackView)
        mapsView.addSubviews(currentLocationButton,
                             listButton)
        
        chipButtons.forEach {
            chipStackView.addArrangedSubview($0)
        }
        
        mapsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        chipStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20.adjustedHeight)
            $0.leading.equalToSuperview().inset(36.adjustedWidth)
        }
        
        listButton.snp.makeConstraints {
            $0.width.height.equalTo(50.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview().inset(30.adjustedHeight)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.width.height.equalTo(50.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalTo(listButton.snp.top).offset(-8.adjustedHeight)
        }
    }
    
    // MARK: Marker Function
    /// 마커 추가 메소드
    func setMarker() {
        homePinListDummy.forEach {
            let pingleMarker = PINGLEMarker()
            
            pingleMarker.changeStringToStatus(string: $0.category)
            pingleMarker.meetingString = $0.category
            
            let x = Double($0.x) ?? 37.56299678698725
            let y = Double($0.y) ?? 126.8569346126135
            
            pingleMarker.iconImage = NMFOverlayImage(image: setMarkerColor(category: $0.category))
            
            pingleMarker.position = NMGLatLng(lat: x, lng: y)
            pingleMarker.mapView = mapsView.mapView
            homeMarkerList.append(pingleMarker)
        }
    }
    
    /// 마커 이미지 변경 메소드, 추후 이미지 변경 예쩡
    func setMarkerColor(category: String) -> UIImage {
        switch category {
        case "PLAY":
            return ImageLiterals.Home.Map.imgMapPinPlay
        case "STUDY":
            return ImageLiterals.Home.Map.imgMapPinStudy
        case "MULTI":
            return ImageLiterals.Home.Map.imgMapPinMulti
        default:
            return ImageLiterals.Home.Map.imgMapPinPlay
        }
    }
    
    /// 현위치 마커 세팅 메소드
    func setCurrentMarker() {
        currentMarker.position = NMGLatLng(lat: nowLat, lng: nowLng)
        currentMarker.mapView = mapsView.mapView
    }
}

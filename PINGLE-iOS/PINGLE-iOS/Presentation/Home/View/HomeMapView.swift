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
    var nowLat: Double = 37.56681744520662
    var nowLng: Double = 126.97865226075146
    
    var homePinList: [HomePinListResponseDTO] = []

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
            $0.setBackgroundColor(.white, for: .normal)
            $0.setBackgroundColor(.grayscaleG04, for: .highlighted)
            $0.setImage(ImageLiterals.Home.Map.icMapHere, for: .normal)
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.25)
            $0.makeCornerRound(radius: 25.adjusted)
        }
        
        listButton.do {
            $0.setBackgroundColor(.white, for: .normal)
            $0.setBackgroundColor(.grayscaleG04, for: .highlighted)
            $0.setImage(ImageLiterals.Home.Map.icMapList, for: .normal)
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.25)
            $0.makeCornerRound(radius: 25.adjusted)
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
    func setMarkerColor(category: String) -> UIImage {
        switch category {
        case "PLAY":
            return ImageLiterals.Home.Map.imgMapPinPlay
        case "STUDY":
            return ImageLiterals.Home.Map.imgMapPinStudy
        case "MULTI":
            return ImageLiterals.Home.Map.imgMapPinMulti
        default:
            return ImageLiterals.Home.Map.imgMapPinOther
        }
    }
    
    /// 현위치 마커 세팅 메소드
    func setCurrentMarker() {
        currentMarker.position = NMGLatLng(lat: nowLat, lng: nowLng)
        currentMarker.mapView = mapsView.mapView
    }
}

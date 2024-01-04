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
    
    typealias Marker = [Double: Double]
    
    let markerDummy: Marker = [37.56299678698725: 126.8469346126135,
                               37.57299678698725: 126.8569346126135,
                               37.58299678698725: 126.8669346126135,
                               37.59299678698725: 126.8769346126135,
                               37.60299678698725: 126.8669346126135,
                               37.61299678698725: 126.8369346126135,
                               37.62299678698725: 126.8469346126135,
                               37.63299678698725: 126.8769346126135]
    
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
    let locationOverlayIcon = NMFOverlayImage(image: ImageLiterals.Home.Map.icLocationOverlay)
    
    var nowLat: Double = 37.56299678698725
    var nowLng: Double = 126.8569346126135
    
    var locationManager = CLLocationManager()
    lazy var cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.nowLat, lng: self.nowLng))
    
    let marker = NMFMarker()
    let infoWindow = NMFInfoWindow()
    
    let currentMarker = NMFMarker()
    
    let currentLocationButton = UIButton()
    let listButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMarker()
    }
    
    override func setStyle() {
        cameraUpdate.do {
            $0.animation = .easeIn
        }
        
        mapsView.do {
            $0.mapView.positionMode = .direction
            $0.mapView.isNightModeEnabled = true
            $0.mapView.mapType = .navi
            $0.mapView.moveCamera(cameraUpdate)
            $0.showScaleBar = false
            $0.showZoomControls = false
            $0.showCompass = false
            $0.showLocationButton = false
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
    
    private func setMarker() {
        markerDummy.forEach {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: $0, lng: $1)
            marker.mapView = mapsView.mapView
        }
    }
    
    func setCurrentMarker() {
        /// 현위치 마커
        currentMarker.position = NMGLatLng(lat: nowLat, lng: nowLng)
        currentMarker.mapView = mapsView.mapView
    }
}

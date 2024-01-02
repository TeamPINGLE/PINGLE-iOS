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
    
    let mapsView = NMFNaverMapView()
    let locationButton = NMFLocationButton()
    
    var nowLat: Double = 37.56299678698725
    var nowLng: Double = 126.8569346126135
    
    var locationManager = CLLocationManager()
    lazy var cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.nowLat, lng: self.nowLng))
    
    let marker = NMFMarker()
    let infoWindow = NMFInfoWindow()
    
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
            
            let locationOverlay = $0.mapView.locationOverlay
            locationOverlay.circleColor = .red
            locationOverlay.circleRadius = 20
            locationOverlay.circleOutlineColor = .red
            locationOverlay.circleOutlineColor.withAlphaComponent(0.3)
            locationOverlay.circleOutlineWidth = 3
        }
        
        locationButton.do {
            // 수정 필요
            $0.backgroundColor = .white
            $0.mapView = mapsView.mapView
            $0.layer.cornerRadius = 25
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
        }
        
        cameraUpdate.do {
            $0.animation = .easeIn
        }
    }
    
    override func setLayout() {
        self.addSubview(mapsView)
        mapsView.addSubview(locationButton)
        
        mapsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(82)
        }
    }
    
    private func setMarker() {
        markerDummy.forEach {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: $0, lng: $1)
            marker.mapView = mapsView.mapView
        }
    }
}

//
//  HomeMapViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/1/24.
//

import UIKit

import NMapsMap
import SnapKit
import Then

final class HomeMapViewController: BaseViewController {
    let mapsView = HomeMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 60
        
        view.addSubview(mapsView)
        
        mapsView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
    }
    
    private func setLocationManager() {
        mapsView.locationManager.delegate = self
        mapsView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapsView.locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.mapsView.locationManager.startUpdatingLocation()
            } else {
                print("위치 서비스 허용 off")
            }
        }
    }
}

extension HomeMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            mapsView.nowLat = location.coordinate.latitude
            mapsView.nowLng = location.coordinate.longitude
            
            mapsView.cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: mapsView.nowLat, lng: mapsView.nowLng))
            mapsView.cameraUpdate.animation = .easeIn
            self.mapsView.mapsView.mapView.moveCamera(mapsView.cameraUpdate)
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
        }
    }
    
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("error")
    }
}

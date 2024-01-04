//
//  HomeMapViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/1/24.
//

import UIKit

import CoreLocation
import NMapsMap
import SnapKit
import Then

final class HomeMapViewController: BaseViewController {
    
    var shouldUpdateMap: Bool = true
    let mapsView = HomeMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setLocationManager()
        setAddTarget()
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60

        self.view.addSubview(mapsView)
        
        mapsView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
    }
    
    private func setLocationManager() {
        mapsView.locationManager.delegate = self
        mapsView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapsView.locationManager.requestWhenInUseAuthorization()
    }
    
    private func setAddTarget() {
        self.mapsView.chipButtons.forEach {
            $0.addTarget(self, action: #selector(isChipButtonTapped), for: .touchUpInside)
        }
        self.mapsView.currentLocationButton.addTarget(self,
                                             action: #selector(currentLocationButtonTapped),
                                             for: .touchUpInside)
        self.mapsView.listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
    }
}

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
            
        }
    }
    
    // 위치 가져오기 실패
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
                // 여기서 사용자에게 위치 권한을 요청하는 로직을 추가할 수 있습니다.
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

extension HomeMapViewController {
    @objc func isChipButtonTapped(sender: ChipButton) {
        /// 태그 선택 여부 반전
        sender.isButtonSelected.toggle()

        /// 태그 하나만 선택할 수 있도록
        self.mapsView.chipButtons.filter { $0 != sender }.forEach {
            $0.isButtonSelected = false
        }
    }
    
    @objc func listButtonTapped() {
        print("리스트 버튼 탭")
    }
    
    @objc func currentLocationButtonTapped() {
        moveToCurrentLocation()
    }
    
    func moveToCurrentLocation() {
        print("현위치 이동")
        self.mapsView.cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: mapsView.nowLat, lng: mapsView.nowLng))
        self.mapsView.cameraUpdate.animation = .easeIn
        self.mapsView.mapsView.mapView.moveCamera(mapsView.cameraUpdate)
    }
}

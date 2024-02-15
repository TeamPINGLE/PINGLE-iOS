//
//  HomeViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 2/15/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: Property
    var isHomeMap = true
    
    private let homeMapViewController = HomeMapViewController()
    private let homeListViewController = HomeListViewController()
    
    private let homeLogoImageView = UIImageView()
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    private func setAddTarget() {
        homeMapViewController.mapsView.listButton.addTarget(
            self,
            action: #selector(mapListButtonTapped),
            for: .touchUpInside
        )
        homeListViewController.mapButton.addTarget(
            self,
            action: #selector(mapListButtonTapped),
            for: .touchUpInside
        )
    }
    
    override func setStyle() {
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
        
        homeLogoImageView.do {
            $0.image = UIImage(resource: .imgHomeLogo)
        }
        
        searchButton.do {
            $0.setImage(UIImage(resource: .icSearch), for: .normal)
        }
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubviews(homeMapViewController.view,
                         homeListViewController.view,
                         homeLogoImageView,
                         searchButton)
        
        homeMapViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        homeListViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24.adjustedWidth)
            $0.top.equalToSuperview().inset(62.adjustedHeight)
        }
        
        homeLogoImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchButton)
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
        }
    }
    
    @objc func mapListButtonTapped() {
        isHomeMap.toggle()
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
    }
}

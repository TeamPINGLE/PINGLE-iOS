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
    
    let homeMapViewController = HomeMapViewController()
    let homeListViewController = HomeListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    func setAddTarget() {
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
    
    @objc func mapListButtonTapped() {
        isHomeMap.toggle()
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
    }
    
    override func setStyle() {
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubviews(homeMapViewController.view,
                         homeListViewController.view)
        
        homeMapViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        homeListViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
    }
}

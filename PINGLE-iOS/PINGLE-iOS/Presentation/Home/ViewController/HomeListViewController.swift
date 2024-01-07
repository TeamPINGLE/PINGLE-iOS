//
//  HomeListViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/7/24.
//

import UIKit

import SnapKit
import Then

final class HomeListViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let fixView = FixView()
    let mapButton = UIButton()
    
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .grayscaleG11
        
        mapButton.do {
            $0.setBackgroundColor(.white, for: .normal)
            $0.setBackgroundColor(.grayscaleG04, for: .highlighted)
            $0.setImage(ImageLiterals.Home.Map.icMapMap, for: .normal)
            $0.makeShadow(radius: 5, offset: CGSize(width: 0, height: 0), opacity: 0.25)
            $0.makeCornerRound(radius: 25.adjusted)
        }
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        self.view.addSubviews(fixView,
                              mapButton)
        
        fixView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(117.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(50.adjustedWidth)
            $0.bottom.equalTo(safeAreaHeight).offset(-(tabBarHeight + 132.adjustedHeight))
        }
        
        mapButton.snp.makeConstraints {
            $0.width.height.equalTo(50.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalTo(safeAreaHeight).offset(-(tabBarHeight + 30.adjustedHeight))
        }
    }
}

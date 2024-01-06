//
//  RecommendViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class RecommendViewController: BaseViewController {
    
    let fixView = FixView()
    
    override func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .grayscaleG11
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        self.view.addSubviews(fixView)
        fixView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(117.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(50.adjustedWidth)
            $0.bottom.equalTo(safeAreaHeight).offset(-(tabBarHeight + 132.adjustedHeight))
        }
    }
}

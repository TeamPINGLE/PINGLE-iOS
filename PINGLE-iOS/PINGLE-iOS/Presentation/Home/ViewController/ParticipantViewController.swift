//
//  ParticipantViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import UIKit

class ParticipantViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let fixView = FixView()
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .grayscaleG11
    }
    
    // MARK: Style Helpers
    override func setLayout() {
//        let safeAreaHeight = view.safeAreaInsets.bottom
//        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        self.view.addSubviews(fixView)
        fixView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(117.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(50.adjustedWidth)
//            $0.bottom.equalTo(safeAreaHeight).offset(-(tabBarHeight + 132.adjustedHeight))
        }
    }
}

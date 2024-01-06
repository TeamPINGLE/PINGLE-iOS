//
//  SettingViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class SettingViewController: BaseViewController {
    
    // MARK: Property
    private let settingTitleLabel = UILabel()
    private let userNameLabel = UILabel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.settingTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.settingTitle
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        self.userNameLabel.do {
            $0.text = "김핑글"
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(settingTitleLabel, userNameLabel)
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15.adjusted)
            $0.leading.equalTo(self.view).offset(16.adjusted)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.settingTitleLabel.snp.bottom).offset(36.adjusted)
            $0.leading.equalTo(self.view).offset(16.adjusted)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
}


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
    private let organizationButton = OrganizationButton()
    private let settingSelectView = SettingSelectView()
    
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
        self.view.addSubviews(settingTitleLabel, userNameLabel, organizationButton,
                              settingSelectView)
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15.adjusted)
            $0.leading.equalTo(self.view).offset(16.adjusted)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.settingTitleLabel.snp.bottom).offset(36.adjusted)
            $0.leading.equalTo(self.view).offset(16.adjusted)
        }
        
        organizationButton.snp.makeConstraints {
            $0.top.equalTo(self.userNameLabel.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        settingSelectView.snp.makeConstraints {
            $0.top.equalTo(self.organizationButton.snp.bottom).offset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
}


//
//  SettingSelectView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class SettingSelectView: BaseView {

    // MARK: Property
    let contactButton = SettingSelectButton(settingTitle: StringLiterals.Profile.ButtonTitle.contactTitle)
    let noticeButton = SettingSelectButton(settingTitle: StringLiterals.Profile.ButtonTitle.noticeTitle)
    private let versionTitleLabel = UILabel()
    private let versionInfoLabel = UILabel()
    private let horizontalLineView = UIView()
    let logoutButton = SettingSelectButton(settingTitle: StringLiterals.Profile.ButtonTitle.logoutTitle)
    let deleteButton = UIButton()
    private let deleteLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.versionTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.versionTitle
            $0.font = .bodyBodyMed16
            $0.textColor = .white
        }
        
        self.versionInfoLabel.do {
            $0.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG03
        }
        
        self.horizontalLineView.do {
            $0.backgroundColor = .grayscaleG08
        }
        
        self.deleteLabel.do {
            $0.text = StringLiterals.Profile.ButtonTitle.deleteTitle
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG06
            $0.layer.addBorder([.bottom], color: .grayscaleG06, width: 1.0, frameHeight: 17.0, framgeWidth: 42.0.adjusted)
        }
    }
    
    override func setLayout() {
        self.addSubviews(contactButton, noticeButton, versionTitleLabel,
                         versionInfoLabel, horizontalLineView, logoutButton,
                         deleteButton)
        
        self.deleteButton.addSubview(deleteLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.adjusted)
            $0.height.equalTo(328)
        }
        
        contactButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        noticeButton.snp.makeConstraints {
            $0.top.equalTo(self.contactButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        versionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.noticeButton.snp.bottom).offset(14)
            $0.leading.equalToSuperview().inset(4.adjusted)
        }
        
        versionInfoLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.centerY.equalTo(self.versionTitleLabel)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.top.equalTo(self.versionTitleLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(self.versionTitleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(self.logoutButton.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(50.adjustedWidth)
            $0.height.equalTo(45)
        }
        
        deleteLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

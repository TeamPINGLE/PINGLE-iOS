//
//  HomeDetailCancelPopUpView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/7/24.
//

import UIKit

import SnapKit
import Then

final class HomeDetailCancelPopUpView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let cancelButton = UIButton()
    let backButton = UIButton()
    
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Home.Detail.cancelTitle, lineHeight: 25)
            $0.textColor = .white
            $0.font = .subtitleSubSemi18
            $0.textAlignment = .center
        }
        
        descriptionLabel.do {
            $0.text = StringLiterals.Home.Detail.cancelDescription
            $0.textColor = .grayscaleG05
            $0.font = .bodyBodyMed14
            $0.textAlignment = .center
        }
        
        cancelButton.do {
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .white
            $0.setTitle(StringLiterals.Home.Detail.cancelButton, for: .normal)
            $0.setTitleColor(.grayscaleG11, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
        }
        
        backButton.do { 
            $0.setUnderline()
            $0.setTitle(StringLiterals.Home.Detail.backButton, for: .normal)
            $0.setTitleColor(.grayscaleG01, for: .normal)
            $0.titleLabel?.font = .captionCapSemi12
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(titleLabel,
                         descriptionLabel,
                         cancelButton,
                         backButton)
        
        self.snp.makeConstraints {
            $0.width.equalTo(312.adjustedWidth)
            $0.height.equalTo(228)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(46)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(33)
            $0.leading.trailing.equalToSuperview().inset(69.adjustedWidth)
            $0.height.equalTo(42)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(135.adjustedWidth)
            $0.bottom.equalToSuperview().inset(29)
            $0.height.equalTo(17)
        }
    }
}

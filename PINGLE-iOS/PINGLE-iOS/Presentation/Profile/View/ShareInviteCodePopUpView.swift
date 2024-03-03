//
//  ShareInviteCodePopUpView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 3/3/24.
//

import UIKit

import SnapKit
import Then

final class ShareInviteCodePopUpView: BaseView {
    
    // MARK: Property
    private let infoBackgroundView = UIView()
    private let inviteCodeLabel = UILabel()
    private let clipBoardCopyImageView = UIImageView()
    let clipBoardCopyButton = UIButton()
    private let questionLabel = UILabel()
    let shareButton = UIButton()
    
    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        infoBackgroundView.do {
            $0.backgroundColor = .grayscaleG09
            $0.makeCornerRound(radius: 15)
        }
        
        inviteCodeLabel.do {
            $0.text = " "
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        clipBoardCopyImageView.do {
            $0.image = UIImage(resource: .icCopy)
            $0.tintColor = .grayscaleG04
        }
        
        clipBoardCopyButton.do {
            $0.setTitle(StringLiterals.Profile.ButtonTitle.copyInviteCode, for: .normal)
            $0.titleLabel?.font = .captionCapMed12
            $0.setTitleColor(.grayscaleG03, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder([.bottom], color: .grayscaleG03, width: 1.0, frameHeight: 16.0, framgeWidth: 87.0)
        }
        
        questionLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.shareCodeTitle
            $0.font = .bodyBodyMed14
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        shareButton.do {
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .white
            $0.setTitle(StringLiterals.Profile.ButtonTitle.shareTitle, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
        }
    }
    
    override func setLayout() {
        self.addSubviews(infoBackgroundView,
                         inviteCodeLabel,
                         clipBoardCopyImageView,
                         clipBoardCopyButton,
                         questionLabel,
                         shareButton)
        
        self.snp.makeConstraints {
            $0.width.equalTo(327)
            $0.height.equalTo(252)
        }
        
        infoBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(96)
        }
        
        inviteCodeLabel.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView).offset(28)
            $0.centerX.equalTo(infoBackgroundView)
        }
        
        clipBoardCopyImageView.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView).offset(56)
            $0.leading.equalTo(infoBackgroundView).offset(86)
            $0.size.equalTo(20)
        }
        
        clipBoardCopyButton.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView).offset(57)
            $0.leading.equalTo(clipBoardCopyImageView.snp.trailing)
            $0.width.equalTo(87)
            $0.height.equalTo(16)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(185)
            $0.height.equalTo(44)
        }
    }
    
    // MARK: Bind Function
    func bindInviteCode(inviteCode: String) {
        inviteCodeLabel.text = inviteCode
    }
}

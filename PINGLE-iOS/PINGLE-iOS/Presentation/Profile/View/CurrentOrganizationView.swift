//
//  CurrentOrganizationView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class CurrentOrganizationView: BaseView {

    // MARK: Property
    private let backGroundView = UIView()
    private let keywordLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    let lookInviteCodeButton = UIButton()
    private let organizationNameLabel = UILabel()
    private let meetingNumberTitleLabel = UILabel()
    private let meetingNumberLabel = UILabel()
    private let memberNumberTitleLabel = UILabel()
    private let memberNumberLabel = UILabel()
    private let ownerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backGroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .white)
        }
        
        keywordLabel.do {
            $0.font = .captionCapSemi12
            $0.textColor = .mainPingleGreen
            $0.layer.backgroundColor = UIColor.grayscaleG07.cgColor
            $0.makeCornerRound(radius: 12.5)
        }
        
        lookInviteCodeButton.do {
            $0.setTitle(StringLiterals.Profile.ButtonTitle.lookInviteCode, for: .normal)
            $0.titleLabel?.font = .captionCapMed12
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder([.bottom], color: .white, width: 1.0, frameHeight: 17.0, framgeWidth: 66.0)
        }
        
        organizationNameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 28)
            $0.font = .titleTitleSemi20
            $0.textColor = .grayscaleG01
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
        
        meetingNumberTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.meetingNumber
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG03
        }
        
        meetingNumberLabel.do {
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG03
        }
        
        memberNumberTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.memberNumber
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG03
        }
        
        memberNumberLabel.do {
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG03
        }
        
        ownerImageView.do {
            $0.image = UIImage(resource: .imgSelectedOwner)
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.addSubviews(backGroundView,
                         ownerImageView)
        
        backGroundView.addSubviews(keywordLabel,
                                   lookInviteCodeButton,
                                   organizationNameLabel,
                                   meetingNumberTitleLabel,
                                   meetingNumberLabel,
                                   memberNumberTitleLabel,
                                   memberNumberLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 48)
            $0.height.equalTo(157)
        }
        
        backGroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(24)
        }
        
        lookInviteCodeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(17)
            $0.width.equalTo(66)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        meetingNumberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(organizationNameLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(24)
        }
        
        meetingNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(meetingNumberTitleLabel.snp.trailing).offset(18)
            $0.centerY.equalTo(meetingNumberTitleLabel)
        }
        
        memberNumberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(meetingNumberTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(24)
        }
        
        memberNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(meetingNumberLabel)
            $0.centerY.equalTo(memberNumberTitleLabel)
        }
        
        ownerImageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.size.equalTo(58)
        }
    }
    
    func bindData(data: MyTeamsResponseDTO) {
        keywordLabel.text = data.keyword
        organizationNameLabel.text = data.name
        meetingNumberLabel.text = "\(data.meetingCount)개"
        memberNumberLabel.text = "\(data.participantCount)명"
        
        organizationNameLabel.layoutIfNeeded()
        
        let viewHeight =
            129 +
            min(organizationNameLabel.countCurrentLines(), 2) * 28
        
        self.snp.updateConstraints {
            $0.height.equalTo(viewHeight)
        }
        
        if data.isOwner {
            ownerImageView.isHidden = false
        } else {
            ownerImageView.isHidden = true
        }
    }
}

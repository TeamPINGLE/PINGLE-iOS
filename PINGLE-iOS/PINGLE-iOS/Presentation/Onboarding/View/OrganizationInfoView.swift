//
//  OrganizationInfoView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/5/24.
//

import UIKit

import SnapKit
import Then

final class OrganizationInfoView: BaseView {
    
    enum OrganizationInfoViewType {
        case search
        case make
    }
    
    // MARK: Property
    private let keywordLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    private let organizationNameLabel = UILabel()
    private let meetingNumberTitleLabel = UILabel()
    private let meetingNumberLabel = UILabel()
    private let memberNumberTitleLabel = UILabel()
    private let memberNumberLabel = UILabel()
    private let representativeEmailTitleLabel = UILabel()
    private let representativeEmailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(type: OrganizationInfoViewType) {
        super.init(frame: .zero)
        
        switch type {
        case .search:
            setSearchStyle()
            setSearchLayout()
        case .make:
            setMakeStyle()
            setMakeLayout()
        }
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG01
            $0.makeCornerRound(radius: 12)
        }
        
        keywordLabel.do {
            $0.font = .captionCapSemi12
            $0.textColor = .mainPingleGreen
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
            $0.makeCornerRound(radius: 12.5)
        }
        
        organizationNameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 34)
            $0.font = .titleTitleSemi24
            $0.textColor = .black
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
    }
    
    private func setSearchStyle() {
        meetingNumberTitleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.meetingNumber
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG11
        }
        
        meetingNumberLabel.do {
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG08
        }
        
        memberNumberTitleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.memberNumber
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG11
        }
        
        memberNumberLabel.do {
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG08
        }
    }
    
    private func setMakeStyle() {
        representativeEmailTitleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.representativeEmailTextFieldTitle
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG11
        }
        
        representativeEmailLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20)
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG08
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
    }
    
    override func setLayout() {
        addSubviews(keywordLabel, 
                    organizationNameLabel)
        
        self.snp.makeConstraints {
            $0.height.equalTo(157)
            $0.width.equalTo(UIScreen.main.bounds.width - 48)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(23)
        }
    }
    
    private func setSearchLayout() {
        addSubviews(meetingNumberTitleLabel,
                    meetingNumberLabel,
                    memberNumberTitleLabel,
                    memberNumberLabel)
        
        meetingNumberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(organizationNameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(23)
        }
        
        meetingNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(meetingNumberTitleLabel.snp.trailing).offset(18)
            $0.centerY.equalTo(meetingNumberTitleLabel)
        }
        
        memberNumberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(meetingNumberTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(23)
        }
        
        memberNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(meetingNumberLabel)
            $0.centerY.equalTo(memberNumberTitleLabel)
        }
    }
    
    private func setMakeLayout() {
        addSubviews(representativeEmailTitleLabel,
                    representativeEmailLabel)
        
        representativeEmailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(organizationNameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(23)
            $0.width.equalTo(65)
        }
        
        representativeEmailLabel.snp.makeConstraints {
            $0.top.equalTo(representativeEmailTitleLabel)
            $0.leading.equalTo(representativeEmailTitleLabel.snp.trailing).offset(33)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    func bindSearchData(data: OrganizationDetailResponseDTO) {
        keywordLabel.text = data.keyword
        organizationNameLabel.text = data.name
        meetingNumberLabel.text = "\(data.meetingCount)개"
        memberNumberLabel.text = "\(data.participantCount)명"
        
        organizationNameLabel.layoutIfNeeded()
        
        let viewHeight = 
            123 +
            min(organizationNameLabel.countCurrentLines(), 2) * 34
        
        self.snp.updateConstraints {
            $0.height.equalTo(viewHeight)
        }
    }
    
    func bindMakeData(data: MakeTeamsRequestBodyDTO) {
        keywordLabel.text = data.keyword
        organizationNameLabel.text = data.name
        representativeEmailLabel.text = data.email
        
        organizationNameLabel.layoutIfNeeded()
        representativeEmailLabel.layoutIfNeeded()
        
        let viewHeight = 
            79 +
            min(organizationNameLabel.countCurrentLines(), 2) * 34 +
            min(representativeEmailLabel.countCurrentLines(), 2) * 20
        
        self.snp.updateConstraints {
            $0.height.equalTo(viewHeight)
        }
    }
}

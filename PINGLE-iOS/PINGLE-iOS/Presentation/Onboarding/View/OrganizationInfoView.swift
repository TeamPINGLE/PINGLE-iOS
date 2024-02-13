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

    // MARK: Property
    private let keywordLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    private let organizationNameLabel = UILabel()
    private let meetingNumberTitleLabel = UILabel()
    private let meetingNumberLabel = UILabel()
    private let memberNumberTitleLabel = UILabel()
    private let memberNumberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG01
            $0.layer.cornerRadius = 12.adjusted
        }
        
        keywordLabel.do {
            $0.font = .captionCapSemi12
            $0.textColor = .mainPingleGreen
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
            $0.layer.cornerRadius = 12.5.adjusted
        }
        
        organizationNameLabel.do {
            $0.font = .titleTitleSemi24
            $0.textColor = .black
        }
        
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
    
    override func setLayout() {
        addSubviews(keywordLabel, organizationNameLabel, meetingNumberTitleLabel, 
                         meetingNumberLabel, memberNumberTitleLabel, memberNumberLabel)
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23.adjusted)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(23.adjusted)
            $0.height.equalTo(34)
        }
        
        meetingNumberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(organizationNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(23.adjusted)
        }
        
        meetingNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(meetingNumberTitleLabel.snp.trailing).offset(18.adjusted)
            $0.centerY.equalTo(meetingNumberTitleLabel)
        }
        
        memberNumberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(meetingNumberTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(23.adjusted)
        }
        
        memberNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(meetingNumberLabel)
            $0.centerY.equalTo(memberNumberTitleLabel)
        }
    }
    
    func bindData(data: OrganizationDetailResponseDTO) {
        keywordLabel.text = data.keyword
        organizationNameLabel.text = data.name
        meetingNumberLabel.text = "\(data.meetingCount)개"
        memberNumberLabel.text = "\(data.participantCount)명"
    }
}

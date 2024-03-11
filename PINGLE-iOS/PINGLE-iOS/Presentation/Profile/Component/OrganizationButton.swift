//
//  OrganizationButton.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

import SnapKit
import Then

class OrganizationButton: UIButton {
    
    // MARK: Property
    private let organizationTitleLabel = UILabel()
    private var organizationNameLabel = UILabel()
    private let arrowRightImageView = UIImageView()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
        changeOrganizationName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 12
        }
        
        organizationTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.organizationTitle
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG03
        }
        
        organizationNameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 25)
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG01
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
        
        arrowRightImageView.do {
            $0.image = UIImage(resource: .icArrowRight)
            $0.tintColor = .white
        }
    }
    
    func setLayout() {
        addSubviews(organizationTitleLabel,
                    organizationNameLabel,
                    arrowRightImageView)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32)
            $0.height.equalTo(74)
        }
        
        organizationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(21)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(organizationTitleLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(51)
        }
        
        arrowRightImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.width.equalTo(24)
        }
    }
    
    // MARK: SetOrganizationName
    func changeOrganizationName() {
        guard let userGroupName = KeychainHandler.shared.userGroupName else { return }
        organizationNameLabel.text = userGroupName
        
        organizationNameLabel.layoutIfNeeded()
        
        let viewHeight =
            49 +
            min(organizationNameLabel.countCurrentLines(), 2) * 25
        
        self.snp.updateConstraints {
            $0.height.equalTo(viewHeight)
        }
    }
}

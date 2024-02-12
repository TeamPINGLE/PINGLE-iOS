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
    var organizationNameLabel = UILabel()
    private let arrowRightImageView = UIImageView()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 12
        }
        
        self.organizationTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.organizationTitle
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG03
        }
        
        self.organizationNameLabel.do {
            $0.font = .subtitleSubBold18
            $0.textColor = .grayscaleG01
        }
        
        self.arrowRightImageView.do {
            $0.image = UIImage(resource: .icArrowRight)
        }
    }
    
    func setLayout() {
        self.addSubviews(organizationTitleLabel, organizationNameLabel, arrowRightImageView)
        
        self.snp.makeConstraints {
            $0.width.equalTo(343.adjustedWidth)
            $0.height.equalTo(74)
        }
        
        organizationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.organizationTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
        
        arrowRightImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.width.equalTo(24.adjusted)
        }
    }
    
    // MARK: SetOrganizationName
    func changeOrganizationName() {
        organizationNameLabel.text = KeychainHandler.shared.userGroup[0].name
    }
}

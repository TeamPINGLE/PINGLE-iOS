//
//  FixView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class FixView: BaseView {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let graphicImageView = UIImageView()
    
    override func setStyle() {
        titleLabel.do {
            $0.text = StringLiterals.Fix.fixTitle
            $0.font = .titleTitleSemi24
            $0.textColor = .white
        }
        
        descriptionLabel.do {
            $0.text = StringLiterals.Fix.fixDescription
            $0.font = .bodyBodySemi14
            $0.textColor = .white
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        graphicImageView.do {
            $0.backgroundColor = .grayscaleG03
        }
    }
    
    override func setLayout() {
        self.addSubviews(titleLabel,
                         descriptionLabel,
                         graphicImageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
        
        graphicImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(35.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(275)
            $0.height.equalTo(190)
        }
    }
}

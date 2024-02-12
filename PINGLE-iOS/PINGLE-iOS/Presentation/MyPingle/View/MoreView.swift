//
//  MoreView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class MoreView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let talkTitleLabel = UILabel()
    let talkImageView = UIImageView()
    let talkButton = UIButton()
    let moreSeparateView = UIView()
    let deleteTitleLabel = UILabel()
    let deleteImageView = UIImageView()
    let deleteButton = UIButton()
    
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 8)
            $0.makeBorder(width: 1, color: .grayscaleG09)
        }
        
        talkTitleLabel.do {
            $0.text = StringLiterals.MyPingle.List.talk
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG03
            $0.isUserInteractionEnabled = false
        }
        
        talkImageView.do {
            $0.image = UIImage(resource: .icChat)
            $0.isUserInteractionEnabled = false
        }
        
        moreSeparateView.do {
            $0.backgroundColor = .grayscaleG09
        }
        
        deleteTitleLabel.do {
            $0.text = StringLiterals.MyPingle.List.cancel
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG03
            $0.isUserInteractionEnabled = false
        }
        
        deleteImageView.do {
            $0.image = UIImage(resource: .icTrash)
            $0.isUserInteractionEnabled = false
        }
    }
    
    override func setLayout() {
        self.addSubviews(talkButton,
                         moreSeparateView,
                         deleteButton)
        
        talkButton.addSubviews(talkTitleLabel,
                               talkImageView)
        
        deleteButton.addSubviews(deleteTitleLabel,
                                 deleteImageView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(88)
            $0.width.equalTo(135)
        }
        
        talkButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        talkTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }
        
        talkImageView.snp.makeConstraints { 
            $0.trailing.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }
        
        moreSeparateView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        deleteButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        deleteTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }
        
        deleteImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }
    }
}

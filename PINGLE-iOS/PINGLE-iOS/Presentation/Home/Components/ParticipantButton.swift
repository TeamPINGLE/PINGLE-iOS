//
//  ParticipantButton.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class ParticipantButton: UIButton {
    
    let participantsLabel = UILabel()
    let rightArrowImageView = UIImageView()
    let countStackView = UIStackView()
    let currentParticipantsLabel = UILabel()
    let slashLabel = UILabel()
    let totalParticipantsLabel = UILabel()
    let completeLabel = UILabel()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - extension
extension ParticipantButton {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.do {
            $0.makeCornerRound(radius: 40.5)
            $0.backgroundColor = .grayscaleG10
        }
        
        participantsLabel.do {
            $0.text = StringLiterals.Home.Detail.participantsTitle
            $0.textColor = .white
            $0.font = .captionCapMed12
        }
        
        rightArrowImageView.do {
            $0.image = ImageLiterals.Home.Detail.icParticipantArrowActivate
        }
        
        completeLabel.do {
            $0.text = StringLiterals.Home.Detail.complete
            $0.textColor = .grayscaleG06
            $0.font = .subtitleSubSemi16
            $0.isHidden = true
        }
        
        countStackView.do {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.isUserInteractionEnabled = false
        }
        
        currentParticipantsLabel.do {
            $0.text = " "
            $0.font = .titleTitleSemi24
        }
        
        slashLabel.do {
            $0.text = StringLiterals.Home.Detail.slash
            $0.textColor = .grayscaleG06
            $0.font = .titleTitleSemi24
        }
        
        totalParticipantsLabel.do {
            $0.text = " "
            $0.textColor = .grayscaleG06
            $0.font = .subtitleSubSemi16
        }
    }
    
    private func setLayout() {
        self.addSubviews(participantsLabel,
                         rightArrowImageView,
                         completeLabel,
                         countStackView)
        
        countStackView.addArrangedSubviews(currentParticipantsLabel,
                                           slashLabel,
                                           totalParticipantsLabel)
        
        self.snp.makeConstraints {
            $0.width.height.equalTo(81)
        }
        
        participantsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(participantsLabel)
            $0.leading.equalTo(participantsLabel.snp.trailing).offset(1)
        }
        
        completeLabel.snp.makeConstraints {
            $0.top.equalTo(participantsLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        countStackView.snp.makeConstraints {
            $0.top.equalTo(rightArrowImageView.snp.bottom)
            $0.bottom.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }
        
    }
    
}

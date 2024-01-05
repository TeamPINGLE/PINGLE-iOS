//
//  HomeDetailPopUpView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/5/24.
//

import UIKit

import SnapKit
import Then

final class HomeDetailPopUpView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var badgeColor: UIColor? = .subPingleOrange
    var isParticipating: Bool = false
    
    // MARK: Component
    let infoBackgroundView = UIView()
    let badgeImageView = UIImageView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    
    let askLabel = UILabel()
    let participationButton = UIButton()
    
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        infoBackgroundView.do {
            $0.backgroundColor = .grayscaleG09
            $0.makeCornerRound(radius: 15)
        }
        
        badgeImageView.do {
            $0.image = ImageLiterals.Home.Detail.imgStudyBadge
            $0.contentMode = .scaleAspectFill
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: "강남", lineHeight: 25)
            $0.textColor = badgeColor
            $0.font = .subtitleSubSemi18
            $0.textAlignment = .center
            $0.numberOfLines = 3
            $0.lineBreakMode = .byCharWrapping
        }
        
        nameLabel.do {
            $0.text = "박소현"
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodyMed14
            $0.textAlignment = .center
        }
        
        askLabel.do {
            $0.text = StringLiterals.Home.Detail.askDescription
            $0.textColor = .white
            $0.font = .bodyBodyMed14
        }
        
        participationButton.do {
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .white
            $0.setTitle(StringLiterals.Home.Detail.participationButton, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(infoBackgroundView,
                         askLabel,
                         participationButton)
        
        infoBackgroundView.addSubviews(badgeImageView,
                                       titleLabel,
                                       nameLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(327.adjustedWidth)
//            $0.height.equalTo(278)
        }
        
        infoBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(24.adjustedWidth)
//            $0.height.equalTo(126)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30.adjustedWidth)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25)
        }
        
        askLabel.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        participationButton.snp.makeConstraints {
            $0.top.equalTo(askLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(71.adjustedWidth)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
    }
    
    // MARK: Data Bind Func
    func dataBind(data: HomePinDetailResponseDTO) {
        switch data.category {
        case "PLAY":
            badgeColor = .mainPingleGreen
            badgeImageView.image = ImageLiterals.Home.Detail.imgPlayBadge
            
        case "STUDY":
            badgeColor = .subPingleOrange
            badgeImageView.image = ImageLiterals.Home.Detail.imgStudyBadge

        case "MULTI":
            badgeColor = .subPingleYellow
            badgeImageView.image = ImageLiterals.Home.Detail.imgMultiBadge

        case "OTHERS":
            badgeColor = .grayscaleG01
            badgeImageView.image = ImageLiterals.Home.Detail.imgOthersBadge

        default:
            return
        }
        
        titleLabel.textColor = badgeColor
        titleLabel.text = data.name
        nameLabel.text = data.ownerName
        isParticipating = data.isParticipating
    }
}

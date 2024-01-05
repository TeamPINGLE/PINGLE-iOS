//
//  HomeMapDetailView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/5/24.
//

import UIKit

import SnapKit
import Then

final class HomeMapDetailView: BaseView {
    // MARK: - Variables
    // MARK: Property
    var badgeColor: UIColor? = .subPingleOrange
    
    // MARK: Component
    let topBackgroundView = UIView()
    let badgeImageView = UIImageView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    
    let participantsView = UIView()
    let participantsLabel = UILabel()
    let countStackView = UIStackView()
    let currentParticipantsLabel = UILabel()
    let slashLabel = UILabel()
    let totalParticipantsLabel = UILabel()
    let completeLabel = UILabel()
    
    let separateView = UIView()
    
    let bottomBackgroundView = UIView()
    let dateTimeImageView = UIImageView()
    let dateTimeTitleLabel = UILabel()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let locationImageView = UIImageView()
    let locationTitleLabel = UILabel()
    let locationLabel = UILabel()
    
    let talkButton = UIButton()
    let participationButton = UIButton()
    
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        topBackgroundView.do {
            $0.backgroundColor = .grayscaleG11
            $0.makeCornerRound(radius: 15)
        }
        
        badgeImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.image = ImageLiterals.Home.Detail.imgStudyBadge
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: "강남 모각작팟", lineHeight: 25)
            $0.textColor = badgeColor
            $0.font = .subtitleSubSemi18
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: "박소현", lineHeight: 20)
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodyMed14
        }
        
        participantsView.do {
            $0.makeBorder(width: 1.02, color: badgeColor ?? UIColor())
            $0.makeCornerRound(radius: 40)
        }
        
        participantsLabel.do {
            $0.text = StringLiterals.Home.Detail.participantsTitle
            $0.textColor = .white
            $0.font = .captionCapMed12
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
        }
        
        currentParticipantsLabel.do {
            $0.text = "5"
            $0.textColor = badgeColor
            $0.font = .titleTitleSemi30
        }
        
        slashLabel.do {
            $0.text = StringLiterals.Home.Detail.slash
            $0.textColor = .grayscaleG06
            $0.font = .titleTitleSemi30
        }
        
        totalParticipantsLabel.do {
            $0.text = "10"
            $0.textColor = .grayscaleG06
            $0.font = .titleTitleSemi20
        }
        
        separateView.do {
            $0.backgroundColor = .grayscaleG07
        }
        
        bottomBackgroundView.do {
            $0.backgroundColor = .grayscaleG11
            $0.makeCornerRound(radius: 15)
        }
        
        dateTimeImageView.do {
            $0.image = ImageLiterals.Home.Detail.icCalendar
        }
        
        dateTimeTitleLabel.do {
            $0.text = StringLiterals.Home.Detail.dateTimeTitle
            $0.textColor = .grayscaleG01
            $0.font = .bodyBodySemi14
        }
        
        dateLabel.do {
            $0.text = "2023년 12월 31일"
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodySemi14
        }
        
        timeLabel.do {
            $0.setTextWithLineHeight(text: "오후 01:00 ~ 오후 05:00", lineHeight: 20)
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodySemi14
        }
        
        locationImageView.do {
            $0.image = ImageLiterals.Home.Detail.icLocation
        }
        
        locationTitleLabel.do {
            $0.text = StringLiterals.Home.Detail.locationTitle
            $0.textColor = .grayscaleG01
            $0.font = .bodyBodySemi14
        }
        
        locationLabel.do {
            $0.text = "하얀집 2호점"
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodyMed14
        }
        
        talkButton.do {
            $0.setTitle(StringLiterals.Home.Detail.talkButton, for: .normal)
            $0.setTitleColor(.grayscaleG06, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
            $0.makeCornerRound(radius: 10)
            $0.makeBorder(width: 1, color: .grayscaleG06)
            $0.isEnabled = false
        }
        
        participationButton.do {
            $0.setTitle(StringLiterals.Home.Detail.participationButton, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .white
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(topBackgroundView,
                         bottomBackgroundView)
        
        topBackgroundView.addSubviews(badgeImageView,
                                      titleLabel,
                                      nameLabel,
                                      participantsView,
                                      separateView)
        
        participantsView.addSubviews(participantsLabel,
                                     completeLabel,
                                     countStackView)
        
        countStackView.addArrangedSubviews(currentParticipantsLabel,
                                           slashLabel,
                                           totalParticipantsLabel)
        
        bottomBackgroundView.addSubviews(dateTimeImageView,
                                         dateTimeTitleLabel,
                                         dateLabel,
                                         timeLabel,
                                         locationImageView,
                                         locationTitleLabel,
                                         locationLabel,
                                         talkButton,
                                         participationButton)
        
        topBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(327.adjustedWidth)
            $0.height.equalTo(121)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
            $0.top.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom).offset(8)
            $0.leading.equalTo(badgeImageView)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(badgeImageView)
        }
        
        participantsView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.trailing.equalToSuperview().inset(24.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        participantsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(12)
        }
        
        completeLabel.snp.makeConstraints {
            $0.top.equalTo(participantsLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        countStackView.snp.makeConstraints {
            $0.top.equalTo(participantsLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        separateView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(23.adjustedWidth)
        }
        
        bottomBackgroundView.snp.makeConstraints {
            $0.top.equalTo(topBackgroundView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(topBackgroundView)
            $0.height.equalTo(206)
        }
        
        dateTimeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
            $0.top.equalToSuperview().inset(24)
        }
        
        dateTimeTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateTimeImageView)
            $0.leading.equalTo(dateTimeImageView.snp.trailing).offset(2.adjustedWidth)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateTimeImageView)
            $0.leading.equalTo(dateTimeTitleLabel.snp.trailing).offset(47.adjustedWidth)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(dateLabel)
        }
        
        locationImageView.snp.makeConstraints {
            $0.leading.equalTo(dateTimeImageView)
            $0.top.equalTo(dateTimeImageView.snp.bottom).offset(34)
        }
        
        locationTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(2.adjustedWidth)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.centerY.equalTo(locationImageView)
        }
        
        talkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(44)
            $0.width.equalTo(100.adjustedWidth)
        }
        
        participationButton.snp.makeConstraints {
            $0.bottom.equalTo(talkButton)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.height.equalTo(44)
            $0.width.equalTo(185.adjustedWidth)
        }
    }
    
    func dataBind(data: HomePinDetailResponseDTO) {
        titleLabel.text = data.name
        nameLabel.text = data.ownerName
        currentParticipantsLabel.text = String(data.curParticipants)
        totalParticipantsLabel.text = String(data.maxParticipants)
        dateLabel.text = data.date
        timeLabel.text = data.startAt + " ~ " + data.endAt
        
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
        participantsView.makeBorder(width: 1.02, color: badgeColor ?? UIColor())
        currentParticipantsLabel.textColor = badgeColor
        
        /// 모집 완료 상태 (참여 여부 상관 없이)
        if data.curParticipants == data.maxParticipants {
            participationButton.do {
                $0.setTitleColor(.grayscaleG10, for: .normal)
                $0.backgroundColor = .grayscaleG07
                $0.isEnabled = false
            }
            
            participantsView.makeBorder(width: 1.02, color: .grayscaleG06)
            completeLabel.isHidden = false
            countStackView.isHidden = true
        } else {
            /// 모집 미완료, 참여 신청 O
            /// 이미 참여 신청한 경우라면 취소 버튼 활성화, 대화 버튼 활성화
            if data.isParticipating {
                participationButton.setTitle(StringLiterals.Home.Detail.cancelButton, for: .normal)
                talkButton.do {
                    $0.isEnabled = true
                    $0.setTitleColor(.white, for: .normal)
                    $0.makeBorder(width: 1, color: .white)
                }
            }
            
            /// 모집 미완료, 참여 신청 X
            /// 참여 신청 전이라면 참여 버튼 활성화, 대화 버튼 비활성화 (기본값)
        }
    }
}

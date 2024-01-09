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
    var isParticipating: Bool = false
    var openChatURL: String?
    
    // MARK: Component
    let topBackgroundView = UIView()
    let infoGroupView = UIView()
    let badgeImageView = UIImageView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    
    let participantCountButton = ParticipantButton()
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
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 25)
            $0.numberOfLines = 2
            $0.textColor = badgeColor
            $0.font = .subtitleSubBold16
            $0.lineBreakMode = .byCharWrapping
            $0.textAlignment = .left
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20)
            $0.textColor = .grayscaleG05
            $0.font = .bodyBodyMed14
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
            $0.text = " "
            $0.textColor = .grayscaleG02
            $0.font = .bodyBodySemi14
        }
        
        timeLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 20)
            $0.textColor = .grayscaleG02
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
            $0.text = " "
            $0.textColor = .grayscaleG02
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
        
        topBackgroundView.addSubviews(infoGroupView,
                                      participantCountButton,
                                      separateView)
        
        infoGroupView.addSubviews(badgeImageView,
                                  titleLabel,
                                  nameLabel)
        
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
        
        infoGroupView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom).offset(8 - 3)
            $0.leading.equalToSuperview()
            $0.width.equalTo(188.adjustedWidth)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4 - 3)
            $0.leading.bottom.equalToSuperview()
        }
        
        participantCountButton.snp.makeConstraints {
            $0.width.height.equalTo(81)
            $0.trailing.equalToSuperview().inset(24.adjustedWidth)
            $0.centerY.equalToSuperview()
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
    
    // MARK: Data Bind Func
    func dataBind(data: HomePinDetailResponseDTO) {
        titleLabel.text = data.name
        nameLabel.text = data.ownerName
        participantCountButton.currentParticipantsLabel.text = String(data.curParticipants)
        participantCountButton.totalParticipantsLabel.text = String(data.maxParticipants)
        dateLabel.text = data.date.convertToKoreanDate()
        locationLabel.text = data.location
        
        let startAtString = data.startAt.convertToShortTimeFormat() ?? data.startAt
        let endAtString = data.endAt.convertToShortTimeFormat() ?? data.endAt
        timeLabel.text = startAtString + " ~ " + endAtString
        isParticipating = data.isParticipating
        openChatURL = data.chatLink
        
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
        participantCountButton.currentParticipantsLabel.textColor = badgeColor
        
        /// 모집 완료 상태
        if data.curParticipants == data.maxParticipants {
            participantCountButton.completeLabel.isHidden = false
            participantCountButton.countStackView.isHidden = true
            participantCountButton.participantsLabel.textColor = .grayscaleG06
            participantCountButton.rightArrowImageView.image = ImageLiterals.Home.Detail.icParticipantArrow
            
            /// 참여중이 아니라면 참여버튼 비활성화
            if !data.isParticipating {
                participationButton.do {
                    $0.setTitleColor(.grayscaleG10, for: .normal)
                    $0.backgroundColor = .grayscaleG07
                    $0.isEnabled = false
                }
            }
        }
        
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
    }
}

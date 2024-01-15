//
//  FinalSummaryView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class FinalSummaryCardView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var badgeColor: UIColor? = .subPingleOrange
    
    // MARK: Component
    let topBackgroundView = UIView()
    let infoGroupView = UIView()
    let badgeImageView = UIImageView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let formatter = DateFormatter()
    let separateView = UIView()
    let bottomBackgroundView = UIView()
    let dateTimeImageView = UIImageView()
    let dateTimeTitleLabel = UILabel()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let locationImageView = UIImageView()
    let locationTitleLabel = UILabel()
    let locationLabel = UILabel()
    let recruitNumberImageView = UIImageView()
    let recruitNumberTitleLabel = UILabel()
    let recruitNumberLabel = UILabel()

    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        topBackgroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        badgeImageView.do {
            $0.contentMode = .scaleAspectFill
            switch MeetingManager.shared.category {
            case "PLAY":
                badgeImageView.image = ImageLiterals.Meeting.Category.Badge.playBadge
                
            case "STUDY":
                badgeImageView.image = ImageLiterals.Meeting.Category.Badge.studyBadge
                
            case "MULTI":
                badgeImageView.image = ImageLiterals.Meeting.Category.Badge.multiBadge
                
            case "OTHERS":
                badgeImageView.image = ImageLiterals.Meeting.Category.Badge.othersBadge
                
            default:
                return
            }
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: MeetingManager.shared.name, lineHeight: 22)
            $0.numberOfLines = 2
            switch  MeetingManager.shared.category {
            case "PLAY":
                $0.textColor = .mainPingleGreen
                
            case "STUDY":
                $0.textColor = .subPingleOrange
                
            case "MULTI":
                $0.textColor = .subPingleYellow
                
            case "OTHERS":
                $0.textColor = .grayscaleG01
                
            default:
                return
            }
            $0.font = .subtitleSubBold16
            $0.lineBreakMode = .byCharWrapping
            $0.textAlignment = .left
        }
        
        nameLabel.do {
            $0.setTextWithLineHeight(text: KeychainHandler.shared.userName, lineHeight: 20)
            $0.textColor = .grayscaleG05
            $0.font = .bodyBodyMed14
        }
        
        separateView.do {
            $0.backgroundColor = .grayscaleG07
        }
        
        bottomBackgroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        dateTimeImageView.do {
            $0.image = ImageLiterals.Meeting.Icon.icCalendar
        }
        
        dateTimeTitleLabel.do {
            $0.text = StringLiterals.Meeting.FinalResult.FinalResultCard.finalCardCalendar
            $0.textColor = .grayscaleG01
            $0.font = .bodyBodySemi14
        }
        
        dateLabel.do {
            let selectedDate = dateFormat(date: MeetingManager.shared.date)
            $0.text = "\(selectedDate)"
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodyMed14
        }
        
        timeLabel.do {
            let startAt = timeFormat(time: MeetingManager.shared.startAt)
            let endAt = timeFormat(time: MeetingManager.shared.endAt)
            $0.setTextWithLineHeight(text: "\(startAt) ~ \(endAt)", lineHeight: 20)
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodyMed14
        }
        
        locationImageView.do {
            $0.image = ImageLiterals.Home.Detail.icLocation
        }
        
        locationTitleLabel.do {
            $0.text = StringLiterals.Meeting.FinalResult.FinalResultCard.fincalCardPlace
            $0.textColor = .grayscaleG01
            $0.font = .bodyBodySemi14
        }
        
        locationLabel.do {
            $0.text = MeetingManager.shared.location
            $0.textColor = .grayscaleG03
            $0.numberOfLines = 2
            $0.lineBreakMode = .byCharWrapping
            $0.font = .bodyBodyMed14
        }
        
        recruitNumberImageView.do {
            $0.image = ImageLiterals.Meeting.Icon.icUser
        }
        
        recruitNumberTitleLabel.do {
            $0.text = StringLiterals.Meeting.FinalResult.FinalResultCard.finalCardRecruitNumber
            $0.textColor = .grayscaleG01
            $0.font = .bodyBodySemi14
        }
        
        recruitNumberLabel.do {
            let maxParticipants = MeetingManager.shared.maxParticipants
            $0.text = "\(maxParticipants)명"
            $0.textColor = .grayscaleG03
            $0.font = .bodyBodyMed14
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(topBackgroundView, bottomBackgroundView)
        
        topBackgroundView.addSubviews(infoGroupView, separateView)
        
        infoGroupView.addSubviews(badgeImageView, titleLabel, nameLabel)
        
        bottomBackgroundView.addSubviews(dateTimeImageView,
                                         dateTimeTitleLabel,
                                         dateLabel,
                                         timeLabel,
                                         locationImageView,
                                         locationTitleLabel,
                                         locationLabel,
                                         recruitNumberImageView,
                                         recruitNumberTitleLabel,
                                         recruitNumberLabel)
        
        topBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(327.adjustedWidth)
            $0.height.equalTo(120)
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
            $0.width.equalTo(279.adjustedWidth)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4 - 3)
            $0.leading.bottom.equalToSuperview()
        }

        separateView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(23.adjustedWidth)
        }
        
        bottomBackgroundView.snp.makeConstraints {
            $0.top.equalTo(topBackgroundView.snp.bottom)
            $0.width.equalTo(topBackgroundView)
            $0.height.equalTo(181.adjusted)
        }
        
        dateTimeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
            $0.top.equalToSuperview().inset(29)
        }
        
        dateTimeTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateTimeImageView)
            $0.leading.equalTo(dateTimeImageView.snp.trailing).offset(2.adjustedWidth)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateTimeImageView)
            $0.leading.equalTo(dateTimeTitleLabel.snp.trailing).offset(50.adjustedWidth)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.equalTo(dateLabel)
        }
        
        locationImageView.snp.makeConstraints {
            $0.leading.equalTo(dateTimeImageView)
            $0.top.equalTo(dateTimeImageView.snp.bottom).offset(30)
        }
        
        locationTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(2.adjustedWidth)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.centerY.equalTo(locationImageView)
            $0.trailing.equalToSuperview().inset(26.adjusted)
        }
        
        recruitNumberImageView.snp.makeConstraints {
            $0.leading.equalTo(locationImageView)
            $0.top.equalTo(locationImageView.snp.bottom).offset(30.adjusted)
        }
        
        recruitNumberTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(recruitNumberImageView)
            $0.leading.equalTo(recruitNumberImageView.snp.trailing).offset(2.adjustedWidth)
        }
        
        recruitNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(locationLabel)
            $0.centerY.equalTo(recruitNumberImageView)
        }
    }
    
    // MARK: - Function
    private func dateFormat(date: Date) -> String {
        formatter.dateFormat = "yyyy년  MM월  dd일"
        return formatter.string(from: date)
    }
    
    private func timeFormat(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }
    
}

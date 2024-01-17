//
//  MyPINGLECardView.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class MyPINGLECardView: BaseView {
    
    // MARK: - Variables
    // MARK: Property
    var badgeColor: UIColor? = .subPingleOrange
    var isOwner: Bool = false
    var openChatURL: String?
    
    // MARK: Component
    let topBackgroundView = UIView()
    let badgeImageView = UIImageView()
    let dDayLabel = UILabel()
    let dDayBackground = UIView()
    let badgeGroupView = UIView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let topStackView = UIStackView()
    let moreButton = UIButton()
    
    let separateView = UIView()
    let bottomBackgroundView = UIView()
    let dateImageView = UIImageView()
    let dateLabel = UILabel()
    let dateSeparateView = UIView()
    let timeLabel = UILabel()
    let dateStackView = UIStackView()
    
    let locationImageView = UIImageView()
    let locationLabel = UILabel()
    let memberImageView = UIImageView()
    let memberButton = UIButton()
    let memberLabel = UILabel()
    let memberArrow = UIImageView()
    
    let moreView = MoreView()
    
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        topBackgroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        badgeImageView.do {
            $0.image = ImageLiterals.Home.Detail.imgStudyBadge
            $0.contentMode = .scaleAspectFill
        }
        
        dDayLabel.do {
            $0.text = "D-1"
            $0.textColor = .black
            $0.font = .captionCapBold10
        }
        
        dDayBackground.do {
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.text = "하루종일너란바닷속을항해하는나는아쿠아맨헤엄헤엄헤엄"
            $0.setLineSpacing(spacing: 3)
            $0.font = .bodyBodyMed14
            $0.textColor = badgeColor
            $0.lineBreakMode = .byCharWrapping
            $0.numberOfLines = 2
        }
        
        nameLabel.do {
            $0.text = "정채은"
            $0.textColor = .grayscaleG03
            $0.font = .captionCapMed12
        }
        
        topStackView.do {
            $0.axis = .vertical
            $0.spacing = 6
            $0.alignment = .leading
        }
        
        moreButton.do {
            $0.setImage(ImageLiterals.MyPingle.Icon.btnMyPingleMore, for: .normal)
        }
        
        separateView.do {
            $0.backgroundColor = .grayscaleG07
        }
        
        bottomBackgroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        dateImageView.do {
            $0.image = ImageLiterals.MyPingle.Icon.icCalendar
        }
        
        dateLabel.do {
            $0.text = "2024년 1월 17일"
            $0.textColor = .grayscaleG03
            $0.font = .captionCapMed12
        }
        
        dateSeparateView.do {
            $0.backgroundColor = .grayscaleG03
        }
        
        timeLabel.do {
            $0.text = "19:00 ~ 22:00"
            $0.textColor = .grayscaleG03
            $0.font = .captionCapMed12
        }
        
        dateStackView.do {
            $0.axis = .horizontal
            $0.spacing = 6
        }
        
        locationImageView.do {
            $0.image = ImageLiterals.MyPingle.Icon.icLocation
        }
        
        locationLabel.do {
            $0.text = "한국"
            $0.textColor = .grayscaleG03
            $0.font = .captionCapMed12
        }
        
        memberImageView.do {
            $0.image = ImageLiterals.MyPingle.Icon.icUser
        }
        
        memberLabel.do {
            $0.text = "5/10명"
            $0.textColor = .grayscaleG03
            $0.font = .captionCapMed12
            $0.isUserInteractionEnabled = false
        }
        
        memberArrow.do {
            $0.image = ImageLiterals.MyPingle.Icon.icRightArrow
            $0.isUserInteractionEnabled = false
        }
        
        moreView.do {
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.addSubviews(topBackgroundView,
                         bottomBackgroundView,
                         moreView)
        
        topBackgroundView.addSubviews(topStackView,
                                      moreButton,
                                      separateView)
        
        topStackView.addArrangedSubviews(badgeGroupView,
                                         titleLabel,
                                         nameLabel)
        
        badgeGroupView.addSubviews(badgeImageView,
                                   dDayBackground)
        
        dDayBackground.addSubview(dDayLabel)
        
        bottomBackgroundView.addSubviews(dateImageView,
                                         dateStackView,
                                         locationImageView,
                                         locationLabel,
                                         memberImageView,
                                         memberButton)
        
        dateStackView.addArrangedSubviews(dateLabel,
                                          dateSeparateView,
                                          timeLabel)
        
        memberButton.addSubviews(memberLabel,
                                 memberArrow)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 48)
        }
        
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(113)
        }
        
        titleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25.adjustedWidth)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        dDayBackground.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(badgeImageView.snp.trailing).offset(4)
        }
        
        dDayLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(2.5)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        topStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24.adjustedWidth)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview()
        }
        
        separateView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(22.adjustedWidth)
        }
        
        bottomBackgroundView.snp.makeConstraints {
            $0.top.equalTo(topBackgroundView.snp.bottom)
            $0.height.equalTo(116)
            $0.leading.trailing.equalTo(topBackgroundView)
        }
        
        dateImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
            $0.top.equalToSuperview().inset(20)
        }
        
        dateSeparateView.snp.makeConstraints {
            $0.height.equalTo(13)
            $0.width.equalTo(1)
        }
        
        dateStackView.snp.makeConstraints {
            $0.leading.equalTo(dateImageView.snp.trailing).offset(3.adjustedWidth)
            $0.centerY.equalTo(dateImageView)
        }
        
        locationImageView.snp.makeConstraints {
            $0.leading.equalTo(dateImageView)
            $0.top.equalTo(dateImageView.snp.bottom).offset(2)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(3.adjustedWidth)
            $0.centerY.equalTo(locationImageView)
        }
        
        memberImageView.snp.makeConstraints {
            $0.leading.equalTo(dateImageView)
            $0.top.equalTo(locationImageView.snp.bottom).offset(2)
        }
        
        memberButton.snp.makeConstraints {
            $0.centerY.equalTo(memberImageView)
            $0.leading.equalTo(memberImageView.snp.trailing).offset(3.adjustedWidth)
        }
        
        memberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        memberArrow.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.leading.equalTo(memberLabel.snp.trailing).offset(4.adjustedWidth)
        }
        
        moreView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
}

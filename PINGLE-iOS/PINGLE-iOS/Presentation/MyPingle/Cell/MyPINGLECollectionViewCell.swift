//
//  MyPINGLECollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class MyPINGLECollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "MyPINGLECollectionViewCell"
    
    var memberButtonAction: (() -> Void) = {}
    var talkButtonAction: (() -> Void) = {}
    var cancelButtonAction: (() -> Void) = {}
    
    var isMoreViewAppear = false {
        didSet {
            moreView.isHidden = !isMoreViewAppear
        }
    }
    var meetingId: Int = 0
    var isOwner: Bool = false
    private let dimmedTapGesture = UITapGestureRecognizer()
    
    // MARK: Component
    let myPINGLECardView = MyPINGLECardView()
    let dimmedView = UIView()
    let homeDetailCancelPopUpView = HomeDetailCancelPopUpView()
    let moreView = MoreView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setDimmedView()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        talkButtonAction = {}
        cancelButtonAction = {}
        memberButtonAction = {}
        homeDetailCancelPopUpView.cancelButtonAction = {}
        myPINGLECardView.dDayLabel.text = ""
        myPINGLECardView.titleLabel.text = ""
        myPINGLECardView.nameLabel.text = ""
        myPINGLECardView.dateLabel.text = ""
        myPINGLECardView.timeLabel.text = ""
        myPINGLECardView.locationLabel.text = ""
        myPINGLECardView.memberLabel.text = ""
    }
    
    private func setDimmedView() {
        dimmedView.addGestureRecognizer(dimmedTapGesture)
        dimmedTapGesture.delegate = self
    }
    
    // MARK: UI Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        dimmedView.do {
            $0.backgroundColor = .black
            $0.alpha = 0.7
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
        }
        
        homeDetailCancelPopUpView.do {
            $0.isHidden = true
        }
        
        moreView.do {
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        addSubviews(myPINGLECardView,
                    moreView)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviews(dimmedView,
                               homeDetailCancelPopUpView)
        }
        
        myPINGLECardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        homeDetailCancelPopUpView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        moreView.snp.makeConstraints {
            $0.top.equalTo(myPINGLECardView).inset(51)
            $0.trailing.equalTo(myPINGLECardView).inset(24)
        }
    }
    
    private func setAddTarget() {
        moreView.deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTapped),
            for: .touchUpInside
        )
        homeDetailCancelPopUpView.backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        homeDetailCancelPopUpView.cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )
        
        myPINGLECardView.moreButton.addTarget(
            self,
            action: #selector(moreButtonTapped),
            for: .touchUpInside
        )
        moreView.talkButton.addTarget(
            self,
            action: #selector(talkButtonTapped),
            for: .touchUpInside
        )
        moreView.deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTapped),
            for: .touchUpInside
        )
        myPINGLECardView.memberButton.addTarget(
            self,
            action: #selector(memberButtonTapped),
            for: .touchUpInside
        )
    }
}

extension MyPINGLECollectionViewCell {
    @objc private func memberButtonTapped() {
        memberButtonAction()
    }
    
    @objc private func moreButtonTapped() {
        isMoreViewAppear.toggle()
    }
    
    @objc private func talkButtonTapped() {
        talkButtonAction()
    }
    
    @objc private func backButtonTapped() {
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        AmplitudeInstance.shared.track(eventType: .clickSoonpingleMoreCancelBack)
    }
    
    @objc private func cancelButtonTapped() {
        homeDetailCancelPopUpView.cancelButtonAction()
    }
    
    @objc private func deleteButtonTapped() {
        dimmedView.isHidden = false
        homeDetailCancelPopUpView.isHidden = false
    }
    
    func dataBind(data: MyPINGLEResponseDTO) {
        meetingId = data.id
        isOwner = data.isOwner
        myPINGLECardView.dDayBackground.isHidden = data.dDay.isEmpty
        myPINGLECardView.dDayLabel.text = data.dDay
        myPINGLECardView.titleLabel.text = data.name
        myPINGLECardView.nameLabel.text = data.ownerName
        myPINGLECardView.dateLabel.text = data.date.convertToKoreanDate()
        myPINGLECardView.openChatURL = data.chatLink
        
        let startAtString = data.startAt.convertToShortTimeFormat() ?? data.startAt
        let endAtString = data.endAt.convertToShortTimeFormat() ?? data.endAt
        myPINGLECardView.timeLabel.text = startAtString + " ~ " + endAtString
        myPINGLECardView.locationLabel.text = data.location
        myPINGLECardView.memberLabel.text = String(data.curParticipants) + "/" + String(data.maxParticipants) + "명"
        
        if data.isOwner {
            myPINGLECardView.myPingleImageView.isHidden = false
        } else {
            myPINGLECardView.myPingleImageView.isHidden = true
        }
        
        switch data.category {
        case "PLAY":
            myPINGLECardView.badgeColor = .mainPingleGreen
            myPINGLECardView.badgeImageView.image = UIImage(resource: .imgPlayBadge)
            
        case "STUDY":
            myPINGLECardView.badgeColor = .subPingleOrange
            myPINGLECardView.badgeImageView.image = UIImage(resource: .imgStudyBadge)
            
        case "MULTI":
            myPINGLECardView.badgeColor = .subPingleYellow
            myPINGLECardView.badgeImageView.image = UIImage(resource: .imgMultiBadge)
            
        case "OTHERS":
            myPINGLECardView.badgeColor = .grayscaleG01
            myPINGLECardView.badgeImageView.image = UIImage(resource: .imgOthersBadge)
            
        default:
            return
        }
        
        myPINGLECardView.titleLabel.textColor = myPINGLECardView.badgeColor
        updateMoreView(
            isOwner: data.isOwner,
            isActivate: true
        )
        
        homeDetailCancelPopUpView.titleLabel.text = data.isOwner ? StringLiterals.MyPingle.Delete.deleteTitle : StringLiterals.Home.Detail.cancelTitle
        homeDetailCancelPopUpView.descriptionLabel.text = data.isOwner ? StringLiterals.MyPingle.Delete.deleteDescription : StringLiterals.Home.Detail.cancelDescription
        homeDetailCancelPopUpView.cancelButton.setTitle(
            data.isOwner ? StringLiterals.MyPingle.Delete.deleteButton : StringLiterals.Home.Detail.cancelButton,
            for: .normal
        )
    }
    
    private func updateMoreView(
        isOwner: Bool,
        isActivate: Bool
    ) {
        moreView.deleteTitleLabel.text = isOwner ? StringLiterals.MyPingle.List.delete : StringLiterals.MyPingle.List.cancel
        moreView.deleteImageView.image = isActivate ? UIImage(resource: .icTrash) : UIImage(resource: .icTrashDisabled)
        moreView.deleteTitleLabel.textColor = isActivate ? .grayscaleG03 : .grayscaleG08
        moreView.deleteButton.isEnabled = isActivate
    }
    
    func setDoneStyle() {
        myPINGLECardView.dDayBackground.do {
            $0.backgroundColor = .grayscaleG07
        }
        
        myPINGLECardView.dDayLabel.do {
            $0.text = StringLiterals.MyPingle.List.done
            $0.textColor = .grayscaleG11
        }
    }
}

// MARK: UIGestureRecognizerDelegate
extension MyPINGLECollectionViewCell: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        AmplitudeInstance.shared.track(eventType: .clickSoonpingleMoreCancelBack)
        return true
    }
}

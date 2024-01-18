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
    let dimmedTapGesture = UITapGestureRecognizer()
    
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
        self.talkButtonAction = {}
        self.cancelButtonAction = {}
        self.memberButtonAction = {}
        self.homeDetailCancelPopUpView.cancelButtonAction = {}
    }
    
    private func setDimmedView() {
        self.dimmedView.addGestureRecognizer(dimmedTapGesture)
        self.dimmedTapGesture.delegate = self
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
        self.addSubviews(myPINGLECardView,
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
        self.moreView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        self.homeDetailCancelPopUpView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.homeDetailCancelPopUpView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        self.myPINGLECardView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        self.moreView.talkButton.addTarget(self, action: #selector(talkButtonTapped), for: .touchUpInside)
        self.moreView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        self.myPINGLECardView.memberButton.addTarget(self, action: #selector(memberButtonTapped), for: .touchUpInside)
    }
}

extension MyPINGLECollectionViewCell {
    @objc func memberButtonTapped() {
        memberButtonAction()
    }
    
    @objc func moreButtonTapped() {
        isMoreViewAppear.toggle()
    }
    
    @objc func talkButtonTapped() {
        talkButtonAction()
        print("대화하기")
    }
    
    @objc func backButtonTapped() {
        print("돌아가기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
    }
    
    @objc func cancelButtonTapped() {
        print("취소하기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        homeDetailCancelPopUpView.cancelButtonAction()
    }
    
    @objc func deleteButtonTapped() {
        dimmedView.isHidden = false
        homeDetailCancelPopUpView.isHidden = false
        print("참여 취소하기")
    }
    
    func dataBind(data: MyPINGLEResponseDTO) {
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
            myPINGLECardView.badgeImageView.image = ImageLiterals.Home.Detail.imgPlayBadge
            
        case "STUDY":
            myPINGLECardView.badgeColor = .subPingleOrange
            myPINGLECardView.badgeImageView.image = ImageLiterals.Home.Detail.imgStudyBadge
            
        case "MULTI":
            myPINGLECardView.badgeColor = .subPingleYellow
            myPINGLECardView.badgeImageView.image = ImageLiterals.Home.Detail.imgMultiBadge
            
        case "OTHERS":
            myPINGLECardView.badgeColor = .grayscaleG01
            myPINGLECardView.badgeImageView.image = ImageLiterals.Home.Detail.imgOthersBadge
            
        default:
            return
        }
        
        myPINGLECardView.titleLabel.textColor = myPINGLECardView.badgeColor
        updateMoreView(isOwner: data.isOwner, isActivate: !data.isOwner)
    }
    
    func updateMoreView(isOwner: Bool, isActivate: Bool) {
        moreView.deleteTitleLabel.text = isOwner ? StringLiterals.MyPingle.List.delete : StringLiterals.MyPingle.List.cancel
        moreView.deleteImageView.image = isActivate ? ImageLiterals.MyPingle.Icon.icTrash : ImageLiterals.MyPingle.Icon.icTrashDisabled
        moreView.deleteTitleLabel.textColor = isActivate ? .grayscaleG03 : .grayscaleG08
        moreView.deleteButton.isEnabled = isActivate
    }
}

// MARK: UIGestureRecognizerDelegate
extension MyPINGLECollectionViewCell: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        return true
    }
}

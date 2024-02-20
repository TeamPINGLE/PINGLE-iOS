//
//  HomeListCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 2/17/24.
//

import UIKit

import SnapKit
import Then

final class HomeListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "HomeListCollectionViewCell"
    
    var isExpand = false {
        didSet {
            updateAppearance()
        }
    }
    private var expandedConstraint: Constraint?
    private var collapsedConstraint: Constraint?

    let homeListDetailView = HomeListDetailView()
    
    private let dimmedView = UIView()
    let homeDetailPopUpView = HomeDetailPopUpView()
    let homeDetailCancelPopUpView = HomeDetailCancelPopUpView()
    
    private let dimmedTapGesture = UITapGestureRecognizer()
    var memberButtonAction: (() -> Void) = {}
     
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
        homeListDetailView.participantsButtonAction = {}
        homeListDetailView.talkButtonAction = {}
        homeDetailPopUpView.participantionButtonAction = {}
        homeDetailCancelPopUpView.cancelButtonAction = {}
        memberButtonAction = {}
    }
    
    private func setDimmedView() {
        dimmedView.addGestureRecognizer(dimmedTapGesture)
        dimmedTapGesture.delegate = self
    }
    
    private func setAddTarget() {
        homeDetailCancelPopUpView.backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        homeDetailPopUpView.participationButton.addTarget(
            self,
            action: #selector(participationButtonTapped),
            for: .touchUpInside
        )
        homeDetailCancelPopUpView.cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )
        homeListDetailView.participantCountButton.addTarget(
            self,
            action: #selector(participantCountButtonTapped),
            for: .touchUpInside
        )
        homeListDetailView.toggleButton.addTarget(
            self,
            action: #selector(toggleButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func setUI() {
        setStyle()
        setLayout()
        updateAppearance()
    }
    
    private func setStyle() { }
    
    private func setLayout() {
        self.addSubviews(homeListDetailView)
        
        homeListDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        homeListDetailView.bottomBackgroundView.snp.prepareConstraints {
            expandedConstraint = $0.height.equalTo(230).constraint
            expandedConstraint?.layoutConstraints.first?.priority = .defaultLow
        }
        
        homeListDetailView.bottomBackgroundView.snp.prepareConstraints {
            collapsedConstraint = $0.height.equalTo(24).constraint
            collapsedConstraint?.layoutConstraints.first?.priority = .defaultLow
        }
        
        expandedConstraint?.isActive = false
        collapsedConstraint?.isActive = true
    }
    
    private func updateAppearance() {
        collapsedConstraint?.isActive = !isExpand
        expandedConstraint?.isActive = isExpand
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * -1)
            self.homeListDetailView.toggleButton.transform = self.isExpand ? upsideDown : .identity
            self.homeListDetailView.toggleButton.snp.remakeConstraints {
                $0.bottom.equalToSuperview().inset(self.isExpand ? 10 : 0)
                $0.centerX.equalToSuperview()
            }
        }
        self.layoutIfNeeded()
    }
    
    func showPopUp(
        isParticipating: Bool,
        isOwner: Bool
    ) {
        dimmedView.isHidden = false
        
        if !isParticipating {
            homeDetailPopUpView.isHidden = false
            print("참여 팝업 보여주기")
        } else {
            homeDetailCancelPopUpView.titleLabel.text = isOwner ? StringLiterals.MyPingle.Delete.deleteTitle : StringLiterals.Home.Detail.cancelTitle
            homeDetailCancelPopUpView.descriptionLabel.text = isOwner ? StringLiterals.MyPingle.Delete.deleteDescription : StringLiterals.Home.Detail.cancelDescription
            homeDetailCancelPopUpView.cancelButton.setTitle(
                isOwner ? StringLiterals.MyPingle.Delete.deleteButton : StringLiterals.Home.Detail.cancelButton,
                for: .normal
            )
            homeDetailCancelPopUpView.isHidden = false
            print("참여취소 / 삭제 팝업 보여주기")
        }
    }
    
    @objc private func backButtonTapped() {
        print("돌아가기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
    }
    
    @objc private func participationButtonTapped() {
        dimmedView.isHidden = true
        homeDetailPopUpView.isHidden = true
        homeDetailPopUpView.participantionButtonAction()
    }
    
    @objc private func cancelButtonTapped() {
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        homeDetailCancelPopUpView.cancelButtonAction()
    }
    
    @objc private func participantCountButtonTapped() {
        memberButtonAction()
    }
    
    @objc private func toggleButtonTapped() {
        isExpand.toggle()
    }
}

// MARK: UIGestureRecognizerDelegate
extension HomeListCollectionViewCell: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        dimmedView.isHidden = true
        homeDetailPopUpView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        return true
    }
}

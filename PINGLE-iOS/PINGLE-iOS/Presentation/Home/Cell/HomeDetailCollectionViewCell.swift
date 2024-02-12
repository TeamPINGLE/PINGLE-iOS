//
//  HomeDetailCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class HomeDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "HomeDetailCollectionViewCell"
    
    let mapDetailView = HomeMapDetailView()
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
        mapDetailView.participantsButtonAction = {}
        mapDetailView.talkButtonAction = {}
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
        mapDetailView.participantCountButton.addTarget(
            self,
            action: #selector(participantCountButtonTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: Layout Helpers
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
        
        homeDetailPopUpView.do {
            $0.isHidden = true
        }
        
        homeDetailCancelPopUpView.do {
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        addSubviews(mapDetailView)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviews(dimmedView,
                               homeDetailPopUpView,
                               homeDetailCancelPopUpView)
        }
        
        mapDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        homeDetailPopUpView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        homeDetailCancelPopUpView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HomeDetailCollectionViewCell {
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
}

// MARK: UIGestureRecognizerDelegate
extension HomeDetailCollectionViewCell: UIGestureRecognizerDelegate {
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

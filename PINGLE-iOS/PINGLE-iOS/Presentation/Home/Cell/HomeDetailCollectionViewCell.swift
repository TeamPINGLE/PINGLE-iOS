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
    let dimmedView = UIView()
    let homeDetailPopUpView = HomeDetailPopUpView()
    let homeDetailCancelPopUpView = HomeDetailCancelPopUpView()
    
    let dimmedTapGesture = UITapGestureRecognizer()
    
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
    }
    
    private func setDimmedView() {
        self.dimmedView.addGestureRecognizer(dimmedTapGesture)
        self.dimmedTapGesture.delegate = self
    }
    
    private func setAddTarget() {
        self.homeDetailCancelPopUpView.backButton.addTarget(self,
                                                            action: #selector(backButtonTapped),
                                                            for: .touchUpInside)
        self.homeDetailPopUpView.participationButton.addTarget(self, action: #selector(participationButtonTapped), for: .touchUpInside)
        self.homeDetailCancelPopUpView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
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
        self.addSubviews(mapDetailView)
        
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
    func showPopUp(isParticipating: Bool) {
        dimmedView.isHidden = false
        if !isParticipating {
            homeDetailPopUpView.isHidden = false
            print("참여 팝업 보여주기")
        } else {
            homeDetailCancelPopUpView.isHidden = false
            print("참여취소 팝업 보여주기")
        }
    }
    
    @objc func backButtonTapped() {
        print("돌아가기 버튼 탭")
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
    }
    
    @objc func participationButtonTapped() {
        dimmedView.isHidden = true
        homeDetailPopUpView.isHidden = true
        homeDetailPopUpView.participantionButtonAction()
    }
    
    @objc func cancelButtonTapped() {
        dimmedView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        homeDetailCancelPopUpView.cancelButtonAction()
    }
}

// MARK: UIGestureRecognizerDelegate
extension HomeDetailCollectionViewCell: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        dimmedView.isHidden = true
        homeDetailPopUpView.isHidden = true
        homeDetailCancelPopUpView.isHidden = true
        return true
    }
}

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

    static let identifier = "MyPINGLECollectionViewCell"
        
    var memberButtonAction: (() -> Void) = {}
    var talkButtonAction: (() -> Void) = {}
    var cancelButtonAction: (() -> Void) = {}
    
    let myPINGLECardView = MyPINGLECardView()
    let dimmedView = UIView()
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
        self.talkButtonAction = {}
        self.cancelButtonAction = {}
        self.memberButtonAction = {}
    }
    
    private func setDimmedView() {
        self.dimmedView.addGestureRecognizer(dimmedTapGesture)
        self.dimmedTapGesture.delegate = self
    }
    
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
    }
    
    private func setLayout() {
        self.addSubviews(myPINGLECardView)
        
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
    }
    
    private func setAddTarget() {
        self.myPINGLECardView.moreView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        self.homeDetailCancelPopUpView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.homeDetailCancelPopUpView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        self.myPINGLECardView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        self.myPINGLECardView.moreView.talkButton.addTarget(self, action: #selector(talkButtonTapped), for: .touchUpInside)
        self.myPINGLECardView.moreView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        self.myPINGLECardView.memberButton.addTarget(self, action: #selector(memberButtonTapped), for: .touchUpInside)
    }
}

extension MyPINGLECollectionViewCell {
    
    @objc func memberButtonTapped() {
        memberButtonAction()
        print("참여자목록")
    }
    
    @objc func moreButtonTapped() {
        myPINGLECardView.moreView.isHidden.toggle()
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

//
//  LoginViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/2/24.
//

import UIKit

import AuthenticationServices
import SnapKit
import Then

class LoginViewController: BaseViewController {
    
    // MARK: Property
    private let logoImageView = UIImageView()
    private let authorizationButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        self.logoImageView.do {
            $0.image = ImageLiterals.TabBar.imgSetting
        }
        
        self.authorizationButton.do {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = .white
            $0.setImage(ImageLiterals.OnBoarding.imgApplelogo, for: .normal)
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.appleLogin, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .subtitleSubSemi16
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 101.adjusted, bottom: 0, right: 0)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 24.adjusted, bottom: 0, right: 0)
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(logoImageView, authorizationButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(81.adjusted)
            $0.centerX.equalTo(self.view.snp.centerX)
            $0.height.equalTo(210.adjusted)
            $0.width.equalTo(180.adjusted)
        }
        
        authorizationButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).inset(69.adjusted)
            $0.centerX.equalTo(self.view.snp.centerX)
            $0.height.equalTo(58.adjusted)
            $0.width.equalTo(343.adjusted)
        }
    }
    
    // MARK: Target Function
    private func setTarget() {
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func handleAuthorizationAppleIDButtonPress() {
        
    }
    
}

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

final class LoginViewController: BaseViewController {
    
    // MARK: Property
    private let logoImageView = UIImageView()
    private let authorizationButton = UIButton()
    private let loginTitleLabel = UILabel()
    private let introduceLabel = UILabel()
    private let adviceLabel = UILabel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.logoImageView.do {
            $0.image = ImageLiterals.TabBar.imgSetting //이후 디자인 변경
        }
        
        self.loginTitleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.loginTitle
            $0.font = .titleTitleExtra40
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        self.introduceLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.loginIntroduce
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG02
        }
        
        self.adviceLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.loginAdvice
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG02
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
        self.view.addSubviews(logoImageView, loginTitleLabel, introduceLabel,
                              adviceLabel, authorizationButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(63.adjusted)
            $0.leading.equalToSuperview().inset(32.adjusted)
            $0.height.equalTo(73.adjusted)
            $0.width.equalTo(73.adjusted)
        }
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(12.adjusted)
            $0.leading.equalToSuperview().inset(32.adjusted)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginTitleLabel.snp.bottom).offset(12.adjusted)
            $0.leading.equalToSuperview().inset(32.adjusted)
        }
        
        adviceLabel.snp.makeConstraints {
            $0.top.equalTo(self.introduceLabel.snp.bottom).offset(3.adjusted)
            $0.leading.equalToSuperview().inset(32.adjusted)
        }
        
        authorizationButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(69.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(58)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32)
        }
    }
    
    // MARK: Target Function
    private func setTarget() {
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func handleAuthorizationAppleIDButtonPress() {
        let onboardingViewController = OnboardingViewController()
        navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
}

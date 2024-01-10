//
//  LoginViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/2/24.
//

import UIKit

import Alamofire
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
            $0.image = ImageLiterals.OnBoarding.imgApplogo
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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: Network Function
    func login(data: LoginRequestBodyDTO) {
        NetworkService.shared.onboardingService.login(bodyDTO: data) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                KeychainHandler.shared.accessToken = data.accessToken
                KeychainHandler.shared.refreshToken = data.refreshToken
                
                /// 사용자가 단체가 있는지 검사
                self.getUserInfo()
            default:
                print("login error")
            }
        }
    }
    
    func getUserInfo() {
        NetworkService.shared.onboardingService.userInfo { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                KeychainHandler.shared.userGroup = data.groups
                if KeychainHandler.shared.userGroup.isEmpty {
                    let onboardingViewController = OnboardingViewController()
                    self.navigationController?.pushViewController(onboardingViewController, animated: true)
                } else {
                    let PINGLETabBarController = PINGLETabBarController()
                    self.view.window?.rootViewController = PINGLETabBarController
                    self.view.window?.makeKeyAndVisible()
                }
            default:
                print("getUserInfo error")
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    ///로그인 성공했을 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let fullName = appleIDCredential.fullName
            
            if let familyName = fullName?.familyName, let givenName = fullName?.givenName {
                let userName = String(describing: familyName) + String(describing: givenName)
                KeychainHandler.shared.userName = userName
            }

            if  let identityToken = appleIDCredential.identityToken,
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                KeychainHandler.shared.providerToken = identifyTokenString
            }
            
            let userName = KeychainHandler.shared.userName
            self.login(data: LoginRequestBodyDTO(provider: "APPLE", name: userName))
            
        default:
            break
        }
    }
    
    /// 로그인 실패했을 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

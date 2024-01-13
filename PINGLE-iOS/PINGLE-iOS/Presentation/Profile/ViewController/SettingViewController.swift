//
//  SettingViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

import Alamofire
import AuthenticationServices
import SafariServices
import SnapKit
import Then

final class SettingViewController: BaseViewController {
    
    // MARK: Variables
    var accountState: AccountState = .logout
    
    // MARK: Property
    private let settingTitleLabel = UILabel()
    private let userNameLabel = UILabel()
    private let organizationButton = OrganizationButton()
    private let settingSelectView = SettingSelectView()
    private let dimmedView = UIView()
    private let accountPopUpView = AccountPopUpView()
    private let dimmedTapGesture = UITapGestureRecognizer()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        organizationButton.changeOrganizationName()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.settingTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.settingTitle
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        self.userNameLabel.do {
            $0.text = KeychainHandler.shared.userName
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        self.dimmedView.do {
            $0.backgroundColor = .black
            $0.alpha = 0.7
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
        }
        
        self.accountPopUpView.do {
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(settingTitleLabel, userNameLabel, organizationButton,
                              settingSelectView)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviews(dimmedView,
                               accountPopUpView)
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15.adjusted)
            $0.leading.equalTo(self.view).offset(16.adjusted)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.settingTitleLabel.snp.bottom).offset(36.adjusted)
            $0.leading.equalTo(self.view).offset(16.adjusted)
        }
        
        organizationButton.snp.makeConstraints {
            $0.top.equalTo(self.userNameLabel.snp.bottom).offset(20.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        settingSelectView.snp.makeConstraints {
            $0.top.equalTo(self.organizationButton.snp.bottom).offset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        accountPopUpView.snp.makeConstraints {
            $0.center.equalTo(dimmedView)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Delegate Function
    override func setDelegate() {
        self.dimmedTapGesture.delegate = self
    }
    
    // MARK: Target Function
    private func setTarget() {
        self.organizationButton.addTarget(self, action: #selector(organizationButtonTapped), for: .touchUpInside)
        self.settingSelectView.contactButton.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        self.settingSelectView.noticeButton.addTarget(self, action: #selector(noticeButtonTapped), for: .touchUpInside)
        self.settingSelectView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        self.settingSelectView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        self.accountPopUpView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.accountPopUpView.changeStateButton.addTarget(self, action: #selector(changeStateButtonTapped), for: .touchUpInside)
        self.dimmedView.addGestureRecognizer(dimmedTapGesture)
    }
    
    // MARK: Objc Function
    @objc func organizationButtonTapped() {
    }
    
    @objc func contactButtonTapped() {
        guard let url = URL(string: "https://pinglepingle.notion.site/585c13c92e1842c7ada334e78b731303?pvs=4") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc func noticeButtonTapped() {
        guard let url = URL(string: "https://pinglepingle.notion.site/38d504b943a4479695b7ca9206c7b732?pvs=4") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc func logoutButtonTapped() {
        accountState = .logout
        accountPopUpView.SetAccountStateMode(state: .logout)
        dimmedView.isHidden = false
        accountPopUpView.isHidden = false
    }
    
    @objc func deleteButtonTapped() {
        accountState = .delete
        accountPopUpView.SetAccountStateMode(state: .delete)
        dimmedView.isHidden = false
        accountPopUpView.isHidden = false
    }
    
    @objc func backButtonTapped() {
        dimmedView.isHidden = true
        accountPopUpView.isHidden = true
    }
    
    @objc func changeStateButtonTapped() {
        switch accountState {
        case .logout:
            return 
//            postLogout()
        case .delete:
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
    
    // MARK: Network Function
//    func postLogout() {
//        NetworkService.shared.profileService.logout() { [weak self] response in
//            guard let self = self else { return }
//            switch response {
//            case .success(let data):
//                if data.code == 200 {
//                    KeychainHandler.shared.logout()
//                    let loginViewController = LoginViewController()
//                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
//                    sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//            default:
//                print("login error")
//            }
//        }
//    }
    
//    func deleteAppleID() {
//        NetworkService.shared.profileService.deleteID { [weak self] response in
//            guard let self = self else { return }
//            switch response {
//            case .success(let data):
//                if data.code == 200 {
//                    KeychainHandler.shared.deleteID()
//                    let loginViewController = LoginViewController()
//                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
//                    sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//            default:
//                print("login error")
//            }
//        }
//    }
}

extension SettingViewController: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        dimmedView.isHidden = true
        accountPopUpView.isHidden = true
        return true
    }
}

extension SettingViewController: ASAuthorizationControllerDelegate {
    ///로그인 성공했을 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let fullName = appleIDCredential.fullName
            
            if let authorizationCode = appleIDCredential.authorizationCode {
                guard let authorizationCodeString = String(data: authorizationCode, encoding: .utf8) else { return }
                KeychainHandler.shared.authorizationCode = authorizationCodeString
//                deleteAppleID()
            }
            
        default:
            break
        }
    }
    
    /// 로그인 실패했을 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
}

extension SettingViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

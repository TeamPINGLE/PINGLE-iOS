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
    private let warningToastView = PINGLEWarningToastView(warningLabel: StringLiterals.ToastView.rejectDelete)
    private let dimmedTapGesture = UITapGestureRecognizer()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindOrganizationName()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTapBarHidden()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        settingTitleLabel.do {
            $0.text = StringLiterals.Profile.ExplainTitle.settingTitle
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        userNameLabel.do {
            $0.text = KeychainHandler.shared.userName
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        dimmedView.do {
            $0.backgroundColor = .black
            $0.alpha = 0.7
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
        }
        
        accountPopUpView.do {
            $0.isHidden = true
        }
        
        warningToastView.do {
            $0.alpha = 0.0
        }
    }
    
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubviews(settingTitleLabel, 
                         userNameLabel,
                         organizationButton,
                         settingSelectView,
                         warningToastView)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviews(dimmedView,
                               accountPopUpView)
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(59)
            $0.leading.equalTo(view).offset(16.adjusted)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(settingTitleLabel.snp.bottom).offset(36)
            $0.leading.equalTo(view).offset(16.adjusted)
        }
        
        organizationButton.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        settingSelectView.snp.makeConstraints {
            $0.top.equalTo(organizationButton.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        accountPopUpView.snp.makeConstraints {
            $0.center.equalTo(dimmedView)
        }
        
        warningToastView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaHeight).offset(-(tabBarHeight + 18))
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setTapBarHidden() {
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Delegate Function
    override func setDelegate() {
        self.dimmedTapGesture.delegate = self
    }
    
    // MARK: Target Function
    private func setTarget() {
        organizationButton.addTarget(self,
                                          action: #selector(organizationButtonTapped),
                                          for: .touchUpInside)
        settingSelectView.contactButton.addTarget(self,
                                                       action: #selector(contactButtonTapped),
                                                       for: .touchUpInside)
        settingSelectView.noticeButton.addTarget(self,
                                                      action: #selector(noticeButtonTapped),
                                                      for: .touchUpInside)
        settingSelectView.logoutButton.addTarget(self,
                                                      action: #selector(logoutButtonTapped),
                                                      for: .touchUpInside)
        settingSelectView.deleteButton.addTarget(self,
                                                      action: #selector(deleteButtonTapped),
                                                      for: .touchUpInside)
        accountPopUpView.backButton.addTarget(self,
                                                   action: #selector(backButtonTapped),
                                                   for: .touchUpInside)
        accountPopUpView.changeStateButton.addTarget(self,
                                                          action: #selector(changeStateButtonTapped),
                                                          for: .touchUpInside)
        dimmedView.addGestureRecognizer(dimmedTapGesture)
    }
    
    // MARK: Objc Function
    @objc private func organizationButtonTapped() {
        let myOrganizationViewController = MyOrganizationViewController()
        self.navigationController?.pushViewController(myOrganizationViewController, animated: true)
    }
    
    @objc private func contactButtonTapped() {
        guard let url = URL(string: "https://pinglepingle.notion.site/585c13c92e1842c7ada334e78b731303?pvs=4") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc private func noticeButtonTapped() {
        guard let url = URL(string: "https://pinglepingle.notion.site/38d504b943a4479695b7ca9206c7b732?pvs=4") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        accountState = .logout
        accountPopUpView.SetAccountStateMode(state: .logout)
        dimmedView.isHidden = false
        accountPopUpView.isHidden = false
    }
    
    @objc private func deleteButtonTapped() {
        accountState = .delete
        accountPopUpView.SetAccountStateMode(state: .delete)
        dimmedView.isHidden = false
        accountPopUpView.isHidden = false
    }
    
    @objc private func backButtonTapped() {
        dimmedView.isHidden = true
        accountPopUpView.isHidden = true
    }
    
    @objc private func changeStateButtonTapped() {
        switch accountState {
        case .logout:
            postLogout()
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
    
    // MARK: WarningToastView Animation Function
    private func showWarningToastView(duration: TimeInterval = 2.0) {
        warningToastView.fadeIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.warningToastView.fadeOut()
        }
    }
    
    // MARK: Network Function
    private func postLogout() {
        NetworkService.shared.profileService.logout() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                if data.code == 200 {
                    KeychainHandler.shared.logout()
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                    sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                    self.navigationController?.popToRootViewController(animated: true)
                }
            default:
                print("login error")
            }
        }
    }
    
    private func deleteAppleID() {
        NetworkService.shared.profileService.deleteID { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                if data.code == 200 {
                    KeychainHandler.shared.deleteID()
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
                    sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                    self.navigationController?.popToRootViewController(animated: true)
                } else if data.code == 400 {
                    // 탈퇴하는 사용자가 단체장일 경우 경고장 띄우고 탈퇴시키지 않음.
                    dimmedView.isHidden = true
                    accountPopUpView.isHidden = true
                    showWarningToastView()
                }
            default:
                print("login error")
            }
        }
    }
    
    // MARK: Bind Function
    private func bindOrganizationName() {
        organizationButton.changeOrganizationName()
    }
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
                deleteAppleID()
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

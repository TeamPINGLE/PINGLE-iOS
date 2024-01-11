//
//  SettingViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

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
    }
    
    @objc func noticeButtonTapped() {
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
            postLogout()
        case .delete:
            print("계정탈퇴 통신")
        }
    }
    
    // MARK: Network Function
    func postLogout() {
        NetworkService.shared.profileService.logout() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                if data.code == 200 {
                    KeychainHandler.shared.logout()
                    let loginViewController = LoginViewController()
                    self.view.window?.rootViewController = loginViewController
                    self.view.window?.makeKeyAndVisible()
                }
            default:
                print("login error")
            }
        }
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

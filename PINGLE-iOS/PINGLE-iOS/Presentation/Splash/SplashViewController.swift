//
//  SplashViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Then

final class SplashViewController: BaseViewController {
    
    // MARK: Component
    private let PINGLELogoImageView = UIImageView()
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingViewController()
    let pingleTabBarController = PINGLETabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        branchProcessing()
    }
    
    override func setStyle() {
        PINGLELogoImageView.do {
            $0.image = UIImage(resource: .imgPINGLELogo)
        }
    }
    
    override func setLayout() {
        view.addSubview(PINGLELogoImageView)
        
        PINGLELogoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(153)
            $0.height.equalTo(191)
        }
    }
    
    // MARK: Select RootViewController Function
    func changeRootViewController(rootViewController: UIViewController) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func branchProcessing() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            AppStoreCheck.shared.checkAndUpdateIfNeeded { isLatestVersion in
                if isLatestVersion {
                    if KeychainHandler.shared.accessToken.isEmpty {
                        /// 어세스 토큰 없는 경우 - 애플 계정을 통한 회원가입을 한 적이 없는 경우
                        self.changeRootViewController(rootViewController: self.loginViewController)
                    } else {
                        /// 어세스 토큰이 있는 경우 - 애플 계정을 통한 회원가입을 한 적이 있는 경우 : 가입한 단체가 있는지 확인하는 통신 코드 구현
                        self.getUserInfo()
                    }
                } else {
                    AppStoreCheck.shared.showUpdateAlert()
                }
            }
        }
    }
    
    // MARK: Network Function
    func getUserInfo() {
        NetworkService.shared.onboardingService.userInfo { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                if let groups = data.groups {
                    KeychainHandler.shared.userGroup = groups
                }
                if KeychainHandler.shared.userGroup.isEmpty {
                    /// 유저가 가입한 단체가 없는 경우 - Onboarding 화면으로 이동하여 단체에 가입하도록 유도
                    self.changeRootViewController(rootViewController: self.onboardingViewController)
                } else {
                    /// 유저가 가입한 단체가 있는 경우 - 메인화면으로 이동
                    self.changeRootViewController(rootViewController: self.pingleTabBarController)
                }
            default:
                changeRootViewController(rootViewController: loginViewController)
            }
        }
    }
}

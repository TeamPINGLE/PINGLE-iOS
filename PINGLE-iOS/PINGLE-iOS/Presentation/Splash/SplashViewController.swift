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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.branchProcessing()
        }
    }
    
    override func setStyle() {
        PINGLELogoImageView.do {
            $0.image = ImageLiterals.OnBoarding.imgPINGLELogo
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
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func branchProcessing() {
        if KeychainHandler.shared.accessToken.isEmpty {
            /// 어세스 토큰 없는 경우 - 애플 계정을 통한 회원가입을 한 적이 없는 경우
            changeRootViewController(rootViewController: loginViewController)
        } else {
            /// 어세스 토큰이 있는 경우 - 애플 계정을 통한 회원가입을 한 적이 있는 경우 : 가입한 단체가 있는지 확인하는 통신 코드 구현
            getUserInfo()
        }
    }
    
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
                    self.changeRootViewController(rootViewController: self.onboardingViewController)
                } else {
                    self.changeRootViewController(rootViewController: self.pingleTabBarController)
                }
            default:
                changeRootViewController(rootViewController: loginViewController)
            }
        }
    }
}

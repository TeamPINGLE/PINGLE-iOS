//
//  SceneDelegate.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/27/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        let networkManager = NetworkManager()
        
        let splashViewController = SplashViewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
        
        let loginViewController = LoginViewController()
        let onboardingViewController = OnboardingViewController()
        let PINGLETabBarController = PINGLETabBarController()
        
        var rootViewController: UIViewController = loginViewController
        
        if KeychainHandler.shared.accessToken.isEmpty {
            /// 어세스 토큰 없는 경우 - 애플 계정을 통한 회원가입을 한 적이 없는 경우
            rootViewController = loginViewController
        } else {
            /// 어세스 토큰이 있는 경우 - 애플 계정을 통한 회원가입을 한 적이 있는 경우 : 가입한 단체가 있는지 확인하는 통신 코드 구현
            networkManager.getUserInfo { [weak self] state in
                guard let self else { return }
                if KeychainHandler.shared.userGroup.isEmpty {
                    /// 가입한 단체가 없는 경우 - 온보딩 화면에서 단체를 선택한 경험이 없는 경우
                    rootViewController = onboardingViewController
                } else {
                    /// 가입한 단체가 있는 경우 - 온보딩 화면에서 단체를 선택한 경험이 있는 경우
                    rootViewController = PINGLETabBarController
                }
            }
        }
        /// 스플래쉬 화면이 시작
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

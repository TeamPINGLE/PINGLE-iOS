//
//  SceneDelegate.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/27/23.
//

import UIKit

import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let splashViewController = SplashViewController()
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController(rootViewController: splashViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
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
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userID = KeychainHandler.shared.userID
        
        if !userID.isEmpty {
            appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("해당 ID는 연동되어있습니다.")
                case .revoked, .notFound:
                    print("해당 ID는 연동되어있지않습니다.")
                    KeychainHandler.shared.logout()
                    DispatchQueue.main.async {
                        let splashViewController = SplashViewController()
                        
                        let navigationController = UINavigationController(rootViewController: splashViewController)
                        
                        self.window?.rootViewController = navigationController
                        self.window?.makeKeyAndVisible()
                    }
                default:
                    break
                }
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        AmplitudeInstance.shared.track(eventType: .openApp)
        AppStoreCheck.shared.checkAndUpdateIfNeeded { isLatestVersion in
            if !isLatestVersion {
                AppStoreCheck.shared.showUpdateAlert()
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        AmplitudeInstance.shared.track(eventType: .closeApp)
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

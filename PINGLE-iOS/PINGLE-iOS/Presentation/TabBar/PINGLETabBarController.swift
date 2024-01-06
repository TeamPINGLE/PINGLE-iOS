//
//  PINGLETabBarController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/1/24.
//

import UIKit

import SnapKit
import Then

final class PINGLETabBarController: UITabBarController {
    
    // MARK: - Variables
    // MARK: Property
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
            self.setTabBarItems()
            self.setTabBarAppearance()
        }
    }
    
    private var tabs: [UIViewController] = []
    
    let homeViewController = HomeMapViewController()
    let recommendViewController = RecommendViewController()
    let addPingleViewController = UIViewController()
    let myPingleViewController = MyPINGLEViewController()
    let settingViewController = UIViewController()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setTabBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 60
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setTabBarItems()
    }
    
    // MARK: Delegate Function
    private func setDelegate() {
        self.delegate = self
    }
    
    // MARK: TabBar Style
    private func setTabBarAppearance() {
        self.selectedIndex = defaultIndex
        self.tabBar.itemPositioning = .fill
        
        let myFont = UIFont.captionCapSemi12
        let fontAttributes = [NSAttributedString.Key.font: myFont,
                              NSAttributedString.Key.foregroundColor: UIColor.grayscaleG07]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: recommendViewController),
            UINavigationController(rootViewController: addPingleViewController),
            UINavigationController(rootViewController: myPingleViewController),
            UINavigationController(rootViewController: settingViewController)
        ]
        
        self.setViewControllers(tabs, animated: true)
        
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor.black
        tabBar.barStyle = UIBarStyle.default
        tabBar.barTintColor = UIColor.black
        
        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        for (index, controller) in tabs.enumerated() {
            if let tabBarItem = controller.tabBarItem {
                let myFont = UIFont.captionCapSemi12
                let textColor = (index == defaultIndex) ? UIColor.white : UIColor.grayscaleG07
                let defaultFontAttributes = [NSAttributedString.Key.font: myFont,
                                             NSAttributedString.Key.foregroundColor: textColor]
                tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
            }
        }
    }
}

// MARK: - extension
// MARK: UITabBarControllerDelegate
extension PINGLETabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let myFont = UIFont.captionCapSemi12

        if let selectedViewController = tabBarController.selectedViewController {
            let selectedFontAttributes = [NSAttributedString.Key.font: myFont,
                                          NSAttributedString.Key.foregroundColor: UIColor.white]
            selectedViewController.tabBarItem.setTitleTextAttributes(selectedFontAttributes, for: .normal)
        }
        
        for (index, controller) in tabBarController.viewControllers!.enumerated() {
            if let tabBarItem = controller.tabBarItem {
                if index != tabBarController.selectedIndex {
                    let defaultFontAttributes = [NSAttributedString.Key.font: myFont,
                                                 NSAttributedString.Key.foregroundColor: UIColor.grayscaleG07]
                    tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
                }
            }
        }
    }
}

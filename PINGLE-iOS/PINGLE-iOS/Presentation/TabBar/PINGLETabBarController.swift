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
    var isHomeMap = true {
        didSet {
            self.setTabs()
            self.setTabBarItems()
        }
    }
    
    private var tabs: [UIViewController] = []
    
    let homeMapViewController = HomeMapViewController()
    let homeListViewController = HomeListViewController()
    let recommendViewController = RecommendViewController()
    let addPingleViewController = UIViewController()
    let myPingleViewController = MyPINGLEViewController()
    let settingViewController = SettingViewController()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setTabBarAppearance()
        setAddTarget()
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
        self.setTabs()
        setTabBarItems()
    }
    
    // MARK: Delegate Function
    private func setDelegate() {
        self.delegate = self
    }
    
    // MARK: TabBar Style
    private func setTabBarAppearance() {
        self.tabBar.itemPositioning = .fill
        
        let myFont = UIFont.captionCapSemi12
        let fontAttributes = [NSAttributedString.Key.font: myFont,
                              NSAttributedString.Key.foregroundColor: UIColor.grayscaleG07]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    func setTabs() {
        let homeViewController = isHomeMap ? homeMapViewController : homeListViewController
        
        tabs = [
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: recommendViewController),
            UINavigationController(rootViewController: addPingleViewController),
            UINavigationController(rootViewController: myPingleViewController),
            UINavigationController(rootViewController: settingViewController)
        ]
    }
    
    func setTabBarItems() {
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
                let textColor = (index == self.selectedIndex) ? UIColor.white : UIColor.grayscaleG07
                let defaultFontAttributes = [NSAttributedString.Key.font: myFont,
                                             NSAttributedString.Key.foregroundColor: textColor]
                tabBarItem.setTitleTextAttributes(defaultFontAttributes, for: .normal)
            }
        }
    }
    
    func setAddTarget() {
        self.homeMapViewController.mapsView.listButton.addTarget(self,
                                                                 action: #selector(mapListButtonTapped),
                                                                 for: .touchUpInside)
        self.homeListViewController.mapButton.addTarget(self, action: #selector(mapListButtonTapped), for: .touchUpInside)
    }
    
    @objc func mapListButtonTapped() {
        self.isHomeMap.toggle()
    }
    
    @objc func goToAddPingle() {
        let navigationController = UINavigationController(rootViewController: MakeMeetingGuideViewController())
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
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
        
        let selectedIndex = tabBarController.selectedIndex
        switch selectedIndex {
        case 3:
            myPingleViewController.soonViewController.myPINGLECollectionView.setContentOffset(CGPoint(x: 0, y: -20), animated: true)
            myPingleViewController.completeViewController.myPINGLECompleteCollectionView.setContentOffset(CGPoint(x: 0, y: -20), animated: true)
        default:
            return
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return false
        }
        
        if selectedIndex != 2 {
            return true
        }
        
        goToAddPingle()
        return false
    }
}

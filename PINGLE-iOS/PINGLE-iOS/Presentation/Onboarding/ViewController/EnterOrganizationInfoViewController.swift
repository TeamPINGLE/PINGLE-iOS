//
//  EnterOrganizationInfoViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/20/24.
//

import UIKit

import SnapKit
import Then

final class EnterOrganizationInfoViewController: BaseViewController {
    
    // MARK: Property
    private let backButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        presentMakeGroupGuideViewController()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
    }
    
    override func setLayout() {
        
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setNavigation() {
        self.title = StringLiterals.Onboarding.NavigationTitle.searchOrganizationNavigation
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.subtitleSubSemi18
        ]
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Present Function
    private func presentMakeGroupGuideViewController() {
        let makeOrganizationGuideViewController = MakeOrganizationGuideViewController()
        makeOrganizationGuideViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(makeOrganizationGuideViewController, animated: true)
    }
}

extension EnterOrganizationInfoViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

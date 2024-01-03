//
//  SearchOrganizationViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/3/24.
//

import UIKit

import SafariServices
import SnapKit
import Then

final class SearchOrganizationViewController: BaseViewController {
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .black
        }
        
        self.backButton.do {
            $0.setImage(ImageLiterals.Icon.imgArrowLeft, for: .normal)
        }
        
        self.titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.searchOrganization
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.numberOfLines = 0
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32.adjusted)
            $0.leading.equalTo(self.view.snp.leading).offset(26.adjusted)
        }
    }
    
    // MARK: Navigation Function
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
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


//
//  OnboardingViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/2/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingViewController: BaseViewController {
    
    // MARK: Property
    private let titleLabel = UILabel()
    private let existingOrganizationButton = UIButton()
    private let makeOrganizationButton = UIButton()
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.onboarding
            $0.setLineSpacing(spacing: 4)
            $0.font = .titleTitleSemi30
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        existingOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.existingOrganization, for: .normal)
            $0.titleLabel?.font = .subtitleSubSemi16
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(UIImage(resource: .imgSearchGraphic), for: .normal)
            $0.alignTextBelow(spacing: 26)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.makeCornerRound(radius: 12)
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
        
        makeOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.makeOrganization, for: .normal)
            $0.titleLabel?.font = .subtitleSubSemi16
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(UIImage(resource: .imgCreateGraphic), for: .normal)
            $0.alignTextBelow(spacing: 26)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.makeCornerRound(radius: 12)
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel, existingOrganizationButton, makeOrganizationButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(105)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        existingOrganizationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.leading.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(224)
            $0.width.equalTo((UIScreen.main.bounds.size.width - 57.adjusted) / 2)
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.trailing.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(224)
            $0.width.equalTo((UIScreen.main.bounds.size.width - 57.adjusted) / 2)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: Target Function
    private func setTarget() {
        existingOrganizationButton.addTarget(self, 
                                             action: #selector(existingOrganizationButtonDidTap),
                                             for: .touchUpInside)
        makeOrganizationButton.addTarget(self, 
                                         action: #selector(makeOrganizationButtonDidTap),
                                         for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func existingOrganizationButtonDidTap() {
        let searchOrganizationViewController = SearchOrganizationViewController()
        navigationController?.pushViewController(searchOrganizationViewController, animated: true)
    }
    
    @objc func makeOrganizationButtonDidTap() {
        let enterOrganizationInfoViewController = EnterOrganizationInfoViewController()
        navigationController?.pushViewController(enterOrganizationInfoViewController, animated: true)
    }
}

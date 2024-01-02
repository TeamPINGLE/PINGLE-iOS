//
//  OnboardingViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/2/24.
//

import UIKit

import SafariServices
import SnapKit
import Then

final class OnboardingViewController: BaseViewController {
    
    // MARK: Property
    private let titleLabel = UILabel()
    private let existingOrganizationButton = UIButton()
    private let makeOrganizationButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .black
        }
        
        self.titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.onboarding
            $0.font = .titleTitleSemi30
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        self.existingOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.existingOrganization, for: .normal)
            $0.titleLabel?.font = .titleTitleSemi20
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(ImageLiterals.OnBoarding.imgSample, for: .normal)
            $0.alignTextBelow(spacing: 11)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.layer.cornerRadius = 12
            $0.layer.backgroundColor = UIColor(red: 0.145, green: 0.161, blue: 0.188, alpha: 1).cgColor
        }
        
        self.makeOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.makeOrganization, for: .normal)
            $0.titleLabel?.font = .titleTitleSemi20
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(ImageLiterals.OnBoarding.imgSample, for: .normal)
            $0.alignTextBelow(spacing: 11)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.layer.cornerRadius = 12
            $0.layer.backgroundColor = UIColor(red: 0.145, green: 0.161, blue: 0.188, alpha: 1).cgColor
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleLabel, existingOrganizationButton, makeOrganizationButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(105.adjusted)
            $0.leading.equalTo(self.view.snp.leading).offset(26.adjusted)
        }
        
        existingOrganizationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34.adjusted)
            $0.leading.equalTo(self.view.snp.leading).offset(24.adjusted)
            $0.height.equalTo(224.adjusted)
            $0.width.equalTo(159.adjusted)
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34.adjusted)
            $0.trailing.equalTo(self.view.snp.trailing).inset(24.adjusted)
            $0.height.equalTo(224.adjusted)
            $0.width.equalTo(159.adjusted)
        }
    }
    
    // MARK: Target Function
    private func setTarget() {
        existingOrganizationButton.addTarget(self, action: #selector(existingOrganizationButtonDidTap), for: .touchUpInside)
        makeOrganizationButton.addTarget(self, action: #selector(makeOrganizationButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func existingOrganizationButtonDidTap() {
        
    }
    
    @objc func makeOrganizationButtonDidTap() {
        guard let url = URL(string: "https://www.google.com") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}

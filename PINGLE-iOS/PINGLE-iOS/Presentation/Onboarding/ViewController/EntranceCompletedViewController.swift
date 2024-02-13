//
//  EntranceCompletedViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class EntranceCompletedViewController: BaseViewController {
    
    // MARK: Property
    private let titleLabel = UILabel()
    private let organizationNameLabel = UILabel()
    private let postpositionLabel = UILabel()
    private let welcomLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let bottomCTAButton = PINGLECTAButton(title: StringLiterals.CTAButton.startTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        changeButton()
        changeOrganizationName()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.entranceTitle
            $0.setLineSpacing(spacing: 5)
            $0.textAlignment = .left
            $0.font = .titleTitleSemi32
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        organizationNameLabel.do {
            $0.font = .subtitleSubSemi16
            $0.textColor = .grayscaleG01
        }
        
        postpositionLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.postposition
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG03
        }
        
        welcomLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.welcomMessage
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG03
        }
        
        backgroundImageView.do {
            $0.image = UIImage(resource: .imgGraphic1)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel, organizationNameLabel, postpositionLabel,
                              welcomLabel, backgroundImageView, bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(126)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        postpositionLabel.snp.makeConstraints {
            $0.leading.equalTo(organizationNameLabel.snp.trailing)
            $0.centerY.equalTo(organizationNameLabel)
        }
        
        welcomLabel.snp.makeConstraints {
            $0.top.equalTo(organizationNameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.centerX.equalToSuperview()
        }
        
        if UIScreen.main.bounds.height > 667 {
            backgroundImageView.snp.makeConstraints {
                $0.bottom.equalTo(bottomCTAButton.snp.top).offset(-16)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(447)
                $0.width.equalTo(475)
            }
        } else {
            backgroundImageView.snp.makeConstraints {
                $0.bottom.equalTo(bottomCTAButton.snp.top).offset(-16)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(353)
            }
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: Target Function
    private func setTarget() {
        bottomCTAButton.addTarget(self, 
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func bottomCTAButtonTapped() {
        let PINGLETabBarController = PINGLETabBarController()
        self.view.window?.rootViewController = PINGLETabBarController
        self.view.window?.makeKeyAndVisible()
    }
    
    // MARK: SetButton
    func changeButton() {
        self.bottomCTAButton.activateButton()
    }
    
    // MARK: SetOrganizationName
    func changeOrganizationName() {
        organizationNameLabel.text = KeychainHandler.shared.userGroup[0].name
    }
}

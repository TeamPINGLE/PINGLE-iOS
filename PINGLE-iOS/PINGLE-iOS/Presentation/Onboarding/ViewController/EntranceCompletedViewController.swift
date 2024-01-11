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
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.entranceTitle
            $0.font = .titleTitleSemi32
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        self.organizationNameLabel.do {
            $0.text = "단체명"
            $0.font = .subtitleSubSemi16
            $0.textColor = .grayscaleG01
        }
        
        self.postpositionLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.postposition
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG03
        }
        
        self.welcomLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.welcomMessage
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG03
        }
        
        self.backgroundImageView.do {
            $0.image = ImageLiterals.OnBoarding.imgGraphic1
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleLabel, organizationNameLabel, postpositionLabel,
                              welcomLabel, backgroundImageView, bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(132.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        postpositionLabel.snp.makeConstraints {
            $0.leading.equalTo(self.organizationNameLabel.snp.trailing)
            $0.centerY.equalTo(self.organizationNameLabel)
        }
        
        welcomLabel.snp.makeConstraints {
            $0.top.equalTo(self.organizationNameLabel.snp.bottom).offset(4.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.bottom.equalTo(self.bottomCTAButton.snp.top).offset(-16.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(353.adjusted)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: Target Function
    private func setTarget() {
        bottomCTAButton.addTarget(self, action: #selector(bottomCTAButtonTapped), for: .touchUpInside)
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
}

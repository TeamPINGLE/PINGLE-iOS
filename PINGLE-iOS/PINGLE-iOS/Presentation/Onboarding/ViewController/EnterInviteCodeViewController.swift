//
//  EnterInviteCodeViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/5/24.
//

import UIKit

import SnapKit
import Then

final class EnterInviteCodeViewController: BaseViewController {
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let organizationInfoView = OrganizationInfoView()
    private let inviteCodeTextFieldView = PINGLETextFieldView(
        titleLabel: StringLiterals.Onboarding.ExplainTitle.inviteCodeTextFieldTitle,
        explainLabel: StringLiterals.Onboarding.SearchBarPlaceholder.inviteCodePlaceholder
    )
    private let infoImageView = UIImageView()
    private let infoMessageLabel = UILabel()
    private let bottomCTAButton = PINGLECTAButton(title: StringLiterals.CTAButton.enterTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    private let warningToastView = PINGLEWarningToastView(warningLabel: StringLiterals.ToastView.wrongCode)
    
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
            $0.text = StringLiterals.Onboarding.ExplainTitle.inviteCodeTitle
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        self.infoImageView.do {
            $0.image = ImageLiterals.Icon.icInfo
            $0.tintColor = .grayscaleG04
        }
        
        self.infoMessageLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.infoMessage
            $0.font = .captionCapMed10
            $0.textColor = .grayscaleG04
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleLabel, organizationInfoView, inviteCodeTextFieldView,
                              infoImageView, infoMessageLabel, bottomCTAButton,
                              warningToastView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32.adjusted)
            $0.leading.equalTo(self.view).offset(26.adjusted)
        }
        
        organizationInfoView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(25.adjusted)
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(157.adjusted)
        }
        
        inviteCodeTextFieldView.snp.makeConstraints {
            $0.top.equalTo(organizationInfoView.snp.bottom).offset(16.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        infoImageView.snp.makeConstraints {
            $0.top.equalTo(inviteCodeTextFieldView.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(inviteCodeTextFieldView)
            $0.width.height.equalTo(10.adjusted)
        }
        
        infoMessageLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoImageView.snp.centerY)
            $0.leading.equalTo(infoImageView.snp.trailing).offset(4.adjusted)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        warningToastView.snp.makeConstraints {
            $0.bottom.equalTo(bottomCTAButton.snp.top).offset(-16.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Delegate
    override func setDelegate() {
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

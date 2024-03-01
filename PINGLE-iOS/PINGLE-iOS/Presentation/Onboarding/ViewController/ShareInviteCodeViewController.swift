//
//  ShareInviteCodeViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 3/1/24.
//

import UIKit

import SnapKit
import Then

final class ShareInviteCodeViewController: BaseViewController {
    
    // MARK: Variables
    var inviteCode: String?
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let organizationNameTextFieldView = PINGLETextFieldView(
        titleLabel: StringLiterals.Onboarding.ExplainTitle.inviteCodeTextFieldTitle,
        explainLabel: ""
    )
    private let clipBoardCopyButton = UIButton()
    private let infoImageView = UIImageView()
    private let infoMessageLabel = UILabel()
    private let warningToastView = PINGLEWarningToastView(warningLabel: StringLiterals.ToastView.impossibleGroup)
    private let bottomCTAButton = PINGLECTAButton(
        title: StringLiterals.CTAButton.shareTitle,
        buttonColor: .grayscaleG08,
        textColor: .grayscaleG10
    )
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.shareInviteCodeTitle, lineHeight: 34)
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.textAlignment = .left
        }
        
        organizationNameTextFieldView.do {
            $0.searchTextField.isEnabled = false
            $0.searchTextField.text = inviteCode
            $0.makeClipBoardCopyImageView()
        }
        
        clipBoardCopyButton.do {
            $0.backgroundColor = .clear
        }
        
        infoImageView.do {
            $0.image = UIImage(resource: .icInfo)
            $0.tintColor = .grayscaleG04
        }
        
        infoMessageLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.shareInviteCodeInfoMessage
            $0.font = .captionCapMed10
            $0.textColor = .grayscaleG04
        }
        
        warningToastView.do {
            $0.alpha = 0.0
        }
        
        bottomCTAButton.do {
            $0.activateButton()
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel,
                         organizationNameTextFieldView,
                         clipBoardCopyButton,
                         infoImageView,
                         infoMessageLabel,
                         warningToastView,
                         bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.leading.equalToSuperview().inset(26)
        }
        
        organizationNameTextFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        clipBoardCopyButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(organizationNameTextFieldView)
        }
        
        infoImageView.snp.makeConstraints {
            $0.top.equalTo(organizationNameTextFieldView.snp.bottom).offset(8)
            $0.leading.equalTo(organizationNameTextFieldView)
            $0.width.height.equalTo(14)
        }
        
        infoMessageLabel.snp.makeConstraints {
            $0.centerY.equalTo(infoImageView)
            $0.leading.equalTo(infoImageView.snp.trailing).offset(4)
        }
        
        warningToastView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(114)
            $0.centerX.equalToSuperview()
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setNavigation() {
        self.title = StringLiterals.Onboarding.NavigationTitle.shareInviteCodeNavigation
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
        clipBoardCopyButton.addTarget(self,
                                  action: #selector(clipBoardCopyButtonTapped),
                                  for: .touchUpInside)
        bottomCTAButton.addTarget(self,
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func clipBoardCopyButtonTapped() {
        
    }
    
    @objc func bottomCTAButtonTapped() {
        showWarningToastView()
    }
    
    // MARK: Animation Function
    private func showWarningToastView(duration: TimeInterval = 2.0) {
        warningToastView.changeWarningMessage(message: StringLiterals.ToastView.CompletedCopy, possible: true)
        
        self.warningToastView.fadeIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.warningToastView.fadeOut()
        }
    }
}

extension ShareInviteCodeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

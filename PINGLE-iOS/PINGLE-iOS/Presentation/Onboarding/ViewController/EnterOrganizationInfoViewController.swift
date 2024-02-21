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
    private let infoButton = UIButton()
    private let titleLabel = UILabel()
    private let organizationNameTextFieldView = PINGLETextFieldView(
        titleLabel: StringLiterals.Onboarding.ExplainTitle.organizationNameTextFieldTitle,
        explainLabel: StringLiterals.Onboarding.SearchBarPlaceholder.organizationNamePlaceholder
    )
    private let representativeEmailTextFieldView = PINGLETextFieldView(
        titleLabel: StringLiterals.Onboarding.ExplainTitle.representativeEmailTextFieldTitle,
        explainLabel: StringLiterals.Onboarding.SearchBarPlaceholder.representativeEmailPlaceholder
    )
    private let infoImageView = UIImageView()
    private let infoMessageLabel = UILabel()
    private let warningToastView = PINGLEWarningToastView(warningLabel: StringLiterals.ToastView.impossibleGroup)
    private let bottomCTAButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    private enum warningToastMessage {
        case possibleName
        case impossibleName
        case impossibleEmail
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presentMakeGroupGuideViewController()
        setNavigation()
        setTarget()
        hideKeyboardWhenTappedAround()
        makeDuplicateButton()
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
        
        infoButton.do {
            $0.setImage(UIImage(resource: .icInfoBig), for: .normal)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.EnterOrganizationInfoTitle, lineHeight: 34)
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.textAlignment = .left
        }
        
        infoImageView.do {
            $0.image = UIImage(resource: .icInfo)
            $0.tintColor = .grayscaleG04
        }
        
        infoMessageLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.emailInfoMessage
            $0.font = .captionCapMed10
            $0.textColor = .grayscaleG04
        }
        
        warningToastView.do {
            $0.alpha = 0.0
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel,
                         organizationNameTextFieldView,
                         representativeEmailTextFieldView,
                         infoImageView,
                         infoMessageLabel,
                         warningToastView,
                         bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(126)
            $0.leading.equalToSuperview().inset(26)
        }
        
        organizationNameTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(225)
            $0.centerX.equalToSuperview()
        }
        
        representativeEmailTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(317)
            $0.centerX.equalToSuperview()
        }
        
        infoImageView.snp.makeConstraints {
            $0.top.equalTo(representativeEmailTextFieldView.snp.bottom).offset(8)
            $0.leading.equalTo(representativeEmailTextFieldView)
            $0.size.equalTo(14)
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
        self.title = StringLiterals.Onboarding.NavigationTitle.makeOrganizationNavigation
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.subtitleSubSemi18
        ]
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
        
        let customInfoButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = customInfoButton
    }
    
    // MARK: Delegate
    override func setDelegate() {
        self.organizationNameTextFieldView.searchTextField.delegate = self
        self.representativeEmailTextFieldView.searchTextField.delegate = self
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        infoButton.addTarget(self,
                             action: #selector(infoButtonTapped),
                             for: .touchUpInside)
        organizationNameTextFieldView.searchTextField.addTarget(self,
                                                          action: #selector(self.textFieldDidChange(_:)),
                                                          for: .editingChanged)
        representativeEmailTextFieldView.searchTextField.addTarget(self,
                                                          action: #selector(self.textFieldDidChange(_:)),
                                                          for: .editingChanged)
        organizationNameTextFieldView.duplicationCheckButton.addTarget(self,
                                                                       action: #selector(duplicationCheckButtonTapped),
                                                                       for: .touchUpInside)
        bottomCTAButton.addTarget(self,
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func infoButtonTapped() {
        presentMakeGroupGuideViewController()
    }
    
    @objc func duplicationCheckButtonTapped() {
        let text = organizationNameTextFieldView.searchTextField.text ?? ""
        let organizationNameText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        organizationNameTextFieldView.searchTextField.text = organizationNameText
        bottomCTAButton.activateButton()
    }
    
    @objc func bottomCTAButtonTapped() {
        let text = representativeEmailTextFieldView.searchTextField.text ?? ""
        print("email = \(text)")
        if text.isValidEmail() {
            
        } else {
            showWarningToastView(message: .impossibleEmail)
        }
    }
    
    // MARK: Present Function
    private func presentMakeGroupGuideViewController() {
        let makeOrganizationGuideViewController = MakeOrganizationGuideViewController()
        makeOrganizationGuideViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(makeOrganizationGuideViewController, animated: true)
    }
    
    // MARK: Active Function
    private func makeDuplicateButton() {
        organizationNameTextFieldView.makeCheckForDuplicationButton()
    }
    
    // MARK: Animation Function
    private func showWarningToastView(message: warningToastMessage, duration: TimeInterval = 2.0) {
        switch message {
        case .possibleName:
            warningToastView.changeWarningMessage(message: StringLiterals.ToastView.possibleGroup, possible: true)
        case .impossibleName:
            warningToastView.changeWarningMessage(message: StringLiterals.ToastView.impossibleGroup, possible: false)
        case .impossibleEmail:
            warningToastView.changeWarningMessage(message: StringLiterals.ToastView.impossibleEmail, possible: false)
        }
        
        self.warningToastView.fadeIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.warningToastView.fadeOut()
        }
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension EnterOrganizationInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if organizationNameTextFieldView.searchTextField == textField {
            let organizationNameText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            
            /// 공백만 입력했을 경우 중복확인 버튼 비활성화, 문자가 있을 경우 중복확인 버튼 활성화
            if organizationNameText.isEmpty {
                organizationNameTextFieldView.impossibleDuplicationButton()
            } else {
                organizationNameTextFieldView.possibleDuplicationButton()
            }
        } else if representativeEmailTextFieldView.searchTextField == textField {
            
        }
    }
}

extension EnterOrganizationInfoViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

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
    private let titleBackgroundView = UIView()
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
        setupKeyboardEvent()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.backButton.do {
            $0.setImage(ImageLiterals.Icon.imgArrowLeft, for: .normal)
        }
        
        self.titleBackgroundView.do {
            $0.backgroundColor = .grayscaleG11
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
        
        self.warningToastView.do {
            $0.alpha = 0.0
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(organizationInfoView, inviteCodeTextFieldView, infoImageView,
                              infoMessageLabel, bottomCTAButton, warningToastView, titleBackgroundView)
        self.titleBackgroundView.addSubviews(titleLabel)
        
        titleBackgroundView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(113.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
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
            $0.centerY.equalTo(infoImageView)
            $0.leading.equalTo(infoImageView.snp.trailing).offset(4.adjusted)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(40.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        warningToastView.snp.makeConstraints {
            $0.bottom.equalTo(bottomCTAButton.snp.top).offset(-16.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Delegate
    override func setDelegate() {
        self.inviteCodeTextFieldView.searchTextField.delegate = self
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
        inviteCodeTextFieldView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        bottomCTAButton.addTarget(self, action: #selector(bottomCTAButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func bottomCTAButtonTapped() {
        //        showWarningToastView()
        let entranceCompletedViewController = EntranceCompletedViewController()
        navigationController?.pushViewController(entranceCompletedViewController, animated: true)
    }
    
    // MARK: setupKeyboard
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension EnterInviteCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            bottomCTAButton.disabledButton()
        } else {
            bottomCTAButton.activateButton()
        }
        print("Text changed: \(textField.text ?? "")")
    }
}

// MARK: Animation Function
extension EnterInviteCodeViewController {
    func showWarningToastView(duration: TimeInterval = 2.0) {
        self.warningToastView.fadeIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.warningToastView.fadeOut()
        }
    }
    // MARK: Objc Function
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardTopY = keyboardFrame.origin.y
        let inviteCodeTextFieldViewBottomY = inviteCodeTextFieldView.frame.origin.y + inviteCodeTextFieldView.frame.size.height
        
        /// 이동량은 검색창 하단부분과 키보드 상단부분의 사이 공백이 46이 유지되도록 했습니다.
        let moveAmount = inviteCodeTextFieldViewBottomY - keyboardTopY + 46
        
        /// 검색창 하단 부분과 키보드 상단 부분의 차이 값이 46보다 작을 경우에만 검색창이 잘 보이도록 움직이게 했습니다.
        if keyboardTopY - inviteCodeTextFieldViewBottomY < 46 {
            UIView.animate(withDuration: 0.3) {
                self.organizationInfoView.transform = CGAffineTransform(translationX: 0, y: -moveAmount)
                self.inviteCodeTextFieldView.transform = CGAffineTransform(translationX: 0, y: -moveAmount)
                self.infoImageView.transform = CGAffineTransform(translationX: 0, y: -moveAmount)
                self.infoMessageLabel.transform = CGAffineTransform(translationX: 0, y: -moveAmount)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        ///키보드가 사라질 때 화면을 원래 위치로 복원하는 작업입니다.
        UIView.animate(withDuration: 0.3) {
            self.organizationInfoView.transform = CGAffineTransform.identity
            self.inviteCodeTextFieldView.transform = CGAffineTransform.identity
            self.infoImageView.transform = CGAffineTransform.identity
            self.infoMessageLabel.transform = CGAffineTransform.identity
        }
    }
}

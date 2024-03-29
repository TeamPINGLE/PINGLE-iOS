//
//  MeetingIntroductionViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/5/24.
//

import UIKit

import SnapKit
import Then

class MeetingIntroductionViewController: BaseViewController {
    
    // MARK: - Property
    private let backButton = UIButton()
    private let progressBar2 = UIImageView()
    private let PINGLEIntroductionTitle = UILabel()
    private let PINGLEIntroductionTextField = PINGLETextFieldView(
        titleLabel: StringLiterals.Meeting.MeetingIntroduction.PINGLETitle,
        explainLabel: StringLiterals.Meeting.MeetingIntroduction.PINGLEExplain)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    private let exitModal = ExitModalView()
    private let dimmedView = UIView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDimmedView()
        navigationController?.navigationBar.isHidden = true
        setTarget()
        hideKeyboardWhenTappedAround()
        setGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        progressBar2.do {
            $0.image = UIImage(resource: .imgProgressBar2)
            $0.contentMode = .scaleAspectFill
        }
        
        PINGLEIntroductionTitle.do {
            $0.text = StringLiterals.Meeting.MeetingIntroduction.introductionTitle
            $0.setLineSpacing(spacing: 4)
            $0.textAlignment = .left
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        exitLabel.do {
            $0.text = StringLiterals.Meeting.MeetingCategory.ExitButton.exitLabel
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG06
        }
        
        exitModal.do {
            $0.isHidden = true
        }
        
        dimmedView.do {
            $0.backgroundColor = .grayscaleG11.withAlphaComponent(0.7)
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, progressBar2,
                              PINGLEIntroductionTitle, PINGLEIntroductionTextField,
                              nextButton, exitLabel, exitButton, dimmedView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar2.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        PINGLEIntroductionTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        PINGLEIntroductionTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(200.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(exitLabel.snp.top).offset(-14.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        exitLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-23.adjusted)
            $0.leading.equalToSuperview().inset(118.adjusted)
            $0.trailing.equalToSuperview().inset(153.adjusted)
        }
        
        exitButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-23.adjusted)
            $0.leading.equalTo(exitLabel.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(exitLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(117.adjusted)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        let dateSelectionViewController = DateSelectionViewController()
        navigationController?.pushViewController(dateSelectionViewController, animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if let textField = sender as? UITextField {
            if let newText = textField.text, !newText.isEmpty {
                MeetingManager.shared.name = newText
                nextButton.activateButton()
            } else {
                nextButton.disabledButton()
            }
        }
    }
    
    @objc func exitButtonTapped() {
        self.view.addSubview(exitModal)
        exitModal.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        exitModal.isHidden = false
        dimmedView.isHidden = false
    }
    
    @objc func exitModalKeepButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickStep2CancelStay)
        exitModal.isHidden = true
        exitModal.removeFromSuperview()
        dimmedView.isHidden = true
    }
    
    @objc func exitModalExitButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickStep2CancelOut)
        exitModal.isHidden = true
        dimmedView.isHidden = true
        self.dismiss(animated: true)
    }
    
    @objc func dimmedViewTapped() {
        hideDimmedViewWhenTapped()
    }
    
    // MARK: Function
    func setTarget() {
        PINGLEIntroductionTextField.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                                              for: .editingChanged)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitModal.exitButton.addTarget(self,
                                       action: #selector(exitModalExitButtonTapped),
                                       for: .touchUpInside)
        exitModal.keepMaking.addTarget(self, action: #selector(exitModalKeepButtonTapped), for: .touchUpInside)
    }
    
    private func setUpDimmedView() {
        dimmedView.isHidden = true
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setDelegate() {
        self.PINGLEIntroductionTextField.searchTextField.delegate = self
    }
    
    private func hideDimmedViewWhenTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dimmedView.isHidden = true
        })
        exitModal.isHidden = true
    }
}

// MARK: - Extension
// MARK: UITextFieldDelegate
extension MeetingIntroductionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {
            return true
        }
        let emojiLength = string.unicodeScalars.filter { $0.isEmoji }.count
        let newLength = currentText.count + string.count - range.length + emojiLength
        let maxLength = 27
        return newLength <= maxLength
    }
}

extension UnicodeScalar {
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, 0x1F300...0x1F5FF, 0x1F680...0x1F6FF, 0x1F700...0x1F77F, 0x1F780...0x1F7FF, 0x1F800...0x1F8FF, 0x1F900...0x1F9FF, 0x1FA00...0x1FA6F, 0x1FA70...0x1FAFF, 0x2600...0x26FF, 0x2700...0x27BF:
            return true
        default:
            return false
        }
    }
}

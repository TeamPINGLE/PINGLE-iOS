//
//  InsertOpenChatLinkViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/8/24.
//

import UIKit

import SnapKit
import Then

class InsertOpenChatLinkViewController: BaseViewController {
    
    // MARK: - Property
    private let backButton = UIButton()
    private let progressBar6 = UIImageView()
    private let openChatTitle = UILabel()
    private let openChatLinkTextField = PINGLETextFieldView(titleLabel: StringLiterals.Meeting.OpenChat.insertChatLinkTitle,
                                                            explainLabel: StringLiterals.Meeting.OpenChat.insertChatLinkExplain)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    private let exitModal = ExitModalView()
    private let dimmedView = UIView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        setUpDimmedView()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigation()
    }
    
    // MARK: - UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Meeting.Icon.icBack, for: .normal)
        }
        
        progressBar6.do {
            $0.image = ImageLiterals.Meeting.ProgressBar.progressBarImage6
            $0.contentMode = .scaleAspectFill
        }
        
        openChatTitle.do {
            $0.text = StringLiterals.Meeting.OpenChat.openChatTitle
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        openChatLinkTextField.do {
            $0.searchTextField.keyboardType = .alphabet
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
        self.view.addSubviews(backButton, progressBar6,
                              openChatTitle, openChatLinkTextField,
                              nextButton, exitLabel, exitButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar6.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        openChatTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        openChatLinkTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(200.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(54.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        exitLabel.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(14.adjusted)
            $0.leading.equalToSuperview().inset(118.adjusted)
            $0.trailing.equalToSuperview().inset(153.adjusted)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(nextButton.snp.bottom).offset(14.adjusted)
            $0.leading.equalTo(exitLabel.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(exitLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(117.adjusted)
        }
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        let finalResultViewController = FinalResultViewController()
        navigationController?.pushViewController(finalResultViewController, animated: true)
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
        exitModal.isHidden = true
        exitModal.removeFromSuperview()
        dimmedView.isHidden = true
    }
    
    @objc func exitModalExitButtonTapped() {
        exitModal.isHidden = true
        dimmedView.isHidden = true
        self.dismiss(animated: true)
    }

    @objc func textFieldDidChange(_ sender: Any?) {
        if let textField = sender as? UITextField {
            if let newText = textField.text, !newText.isEmpty {
                MeetingManager.shared.chatLink = newText
                nextButton.activateButton()
            } else {
                nextButton.disabledButton()
            }
        }
    }
    
    // MARK: Function
    func setTarget() {
        openChatLinkTextField.searchTextField.addTarget(self, action:#selector(self.textFieldDidChange(_:)), for: .editingChanged)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitModal.exitButton.addTarget(self, action: #selector(exitModalExitButtonTapped), for: .touchUpInside)
        exitModal.keepMaking.addTarget(self, action: #selector(exitModalKeepButtonTapped), for: .touchUpInside)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpDimmedView() {
        self.view.addSubview(dimmedView)
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setDelegate() {
        self.openChatLinkTextField.searchTextField.delegate = self
    }
}

// MARK: - Extension
// MARK: UITextFieldDelegate
extension InsertOpenChatLinkViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

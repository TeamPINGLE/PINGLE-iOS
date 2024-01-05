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
    // MARK: Property
    private let backButton = UIButton()
    private let progressBar2 = UIImageView()
    private let PINGLEIntroductionTitle = UILabel()
    private let PINGLEIntroductionTextField = PINGLETextFieldView(
        titleLabel: StringLiterals.Metting.MeetingIntroduction.PINGLETitle,
        explainLabel: StringLiterals.Metting.MeetingIntroduction.PINGLEExplain)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setTarget()
        hideKeyboardWhenTappedAround()
        self.PINGLEIntroductionTextField.searchTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .black
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Metting.Icon.icBack, for: .normal)
        }
        
        progressBar2.do {
            $0.image = ImageLiterals.Metting.ProgressBar.progressBarImage2
            $0.contentMode = .scaleAspectFill
        }
        
        PINGLEIntroductionTitle.do {
            $0.text = StringLiterals.Metting.MeetingIntroduction.introductionTitle
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        exitLabel.do {
            $0.text = StringLiterals.Metting.MettingCategory.ExitButton.exitLabel
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG06
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, progressBar2, 
                              PINGLEIntroductionTitle, PINGLEIntroductionTextField,
                              nextButton, exitLabel, exitButton)
        
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
        print("여기다가 다음 뷰컨 연결 할것임")
    }

    @objc func textFieldDidChange(_ sender: Any?) {
        if let textField = sender as? UITextField {
            if let newText = textField.text, !newText.isEmpty {
                nextButton.activateButton()
            } else {
                nextButton.disabledButton()
            }
        }
    }
    
    // MARK: Function
    func setTarget() {
        PINGLEIntroductionTextField.searchTextField.addTarget(self,
                                                              action:#selector(self.textFieldDidChange(_:)),
                                                              for: .editingChanged)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}

// MARK: Extension
// MARK: UITextFieldDelegate
extension MeetingIntroductionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

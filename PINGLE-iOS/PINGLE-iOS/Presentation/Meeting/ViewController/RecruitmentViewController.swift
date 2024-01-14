//
//  RecruitmentViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/8/24.
//

import UIKit

import SnapKit
import Then

final class RecruitmentViewController: BaseViewController {
    
    // MARK: - Property
    private let backButton = UIButton()
    private let progressBar5 = UIImageView()
    private let recruitTitle = UILabel()
    private let recruitCondition = UILabel()
    private let recruitTextField = UITextField()
    private let plusButton = RecruitButton(title: "+", buttonColor: .white, textColor: .black, touchEnable: true)
    private let minusButton = RecruitButton(title: "-", buttonColor: .grayscaleG08, textColor: .grayscaleG09, touchEnable: false)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    var newText: String = ""
    private let exitModal = ExitModalView()
    private let dimmedView = UIView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setNavigation()
        hideKeyboardWhenTappedAround()
        setInitialNum()
        setUpDimmedView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigation()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Meeting.Icon.icBack, for: .normal)
        }
        
        progressBar5.do {
            $0.image = ImageLiterals.Meeting.ProgressBar.progressBarImage5
            $0.contentMode = .scaleAspectFill
        }
        
        recruitTitle.do {
            $0.setTextWithLineHeight(text: StringLiterals.Meeting.Recruitment.recruitTitle, lineHeight: 34)
            $0.textAlignment = .left
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        recruitCondition.do {
            $0.setTextWithLineHeight(text: StringLiterals.Meeting.Recruitment.recruitCondition, lineHeight: 20)
            $0.textAlignment = .left
            $0.font = .bodyBodyMed14
            $0.numberOfLines = 0
            $0.textColor = .grayscaleG05
        }
        
        recruitTextField.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 12.adjusted
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
            $0.textAlignment = .center
            $0.font = .titleTitleSemi32
            $0.textColor = .white
            $0.tintColor = .mainPingleGreen
            $0.keyboardType = .numberPad
        }
        
        minusButton.do {
            $0.isUserInteractionEnabled = true
        }
        
        plusButton.do {
            $0.isUserInteractionEnabled = true
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
        self.view.addSubviews(backButton, progressBar5,
                              recruitTitle, recruitCondition, recruitTextField,
                              plusButton, minusButton,
                              nextButton, exitLabel, exitButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar5.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        recruitTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        recruitCondition.snp.makeConstraints {
            $0.top.equalTo(recruitTitle.snp.bottom).offset(12.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(295.adjusted)
            $0.leading.equalToSuperview().inset(77.adjusted)
            $0.trailing.equalToSuperview().inset(248.adjusted)
        }
        
        plusButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(295.adjusted)
            $0.leading.equalToSuperview().inset(248.adjusted)
            $0.trailing.equalToSuperview().inset(77.adjusted)
        }
        
        recruitTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(264.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(114.adjusted)
            $0.width.equalTo(81.adjusted)
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
    
    @objc func plusButtonTapped() {
        if let text = recruitTextField.text, var number = Int(text) {
            number += 1
            recruitTextField.text = "\(number)"
            if number > 1 {
                minusButton.activateButton()
            }
            if number > 98 {
                plusButton.disabledButton()
            }
            updateNextButtonState()
        }
    }
    
    @objc func minusButtonTapped() {
        if let text = recruitTextField.text, var number = Int(text) {
            number -= 1
            recruitTextField.text = "\(number)"
            if number < 2 {
                minusButton.disabledButton()
            }
            if number < 100 {
                plusButton.activateButton()
            }
            updateNextButtonState()
        }
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if let text = recruitTextField.text, var number = Int(text) {
            if number < 1 {
                number = 1
                recruitTextField.text = "1"
            }
            if number > 99 {
                number = 99
                recruitTextField.text = "99"
            }
            if number < 2 {
                minusButton.disabledButton()
                nextButton.disabledButton()
            } else if number > 1 {
                minusButton.activateButton()
            }
            if number > 98 {
                plusButton.disabledButton()
            } else if number < 99 {
                plusButton.activateButton()
            }
            if number > 1 && number < 100 {
                nextButton.activateButton()
            }
            updateNextButtonState()
        }
    }
    
    @objc func nextButtonTapped() {
        let insertOpenChatLinkViewController = InsertOpenChatLinkViewController()
        navigationController?.pushViewController(insertOpenChatLinkViewController, animated: true)
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
    
    // MARK: Function
    func setTarget() {
        recruitTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitModal.exitButton.addTarget(self, action: #selector(exitModalExitButtonTapped), for: .touchUpInside)
        exitModal.keepMaking.addTarget(self, action: #selector(exitModalKeepButtonTapped), for: .touchUpInside)
    }
    
    private func setUpDimmedView() {
        self.view.addSubview(dimmedView)
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setInitialNum() {
        recruitTextField.text = "1"
        updateNextButtonState()
    }
    
    func updateNextButtonState() {
        if let text = recruitTextField.text, let number = Int(text), number > 1, number < 100 {
            nextButton.activateButton()
            MeetingManager.shared.maxParticipants = number
        } else {
            nextButton.disabledButton()
        }
    }
    
    override func setDelegate() {
        self.recruitTextField.delegate = self
    }
}

// MARK: Extension
// MARK: UITextFieldDelegate
extension RecruitmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

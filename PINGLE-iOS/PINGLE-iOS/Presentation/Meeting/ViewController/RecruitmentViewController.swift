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
    // MARK: Property
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
    private let warningToastView = PINGLEWarningToastView(warningLabel: StringLiterals.Meeting.Recruitment.warningLabel)
    var newText: String = ""
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setNavigation()
        hideKeyboardWhenTappedAround()
        setInitialNum()
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
            $0.setImage(ImageLiterals.Metting.Icon.icBack, for: .normal)
        }
        
        progressBar5.do {
            $0.image = ImageLiterals.Metting.ProgressBar.progressBarImage5
            $0.contentMode = .scaleAspectFill
        }
        
        recruitTitle.do {
            $0.text = StringLiterals.Meeting.Recruitment.recruitTitle
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        recruitCondition.do {
            $0.text = StringLiterals.Meeting.Recruitment.recruitCondition
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
        
        warningToastView.do {
            $0.alpha = 0.0
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, progressBar5,
                              recruitTitle, recruitCondition, recruitTextField,
                              plusButton, minusButton,
                              nextButton, exitLabel, exitButton, warningToastView)
        
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(187.adjusted)
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
            $0.bottom.equalToSuperview().inset(54.adjusted)
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
//        
//        warningToastView.snp.makeConstraints {
//            $0.bottom.equalTo(nextButton.snp.top).offset(-16.adjusted)
//            $0.centerX.equalToSuperview()
//        }
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func plusButtonTapped() {
        print("눌렸어염")
        if let text = recruitTextField.text, var number = Int(text) {
            number += 1
            recruitTextField.text = "\(number)"
            if number > 1 {
                print("Entering minusButton.activateButton()")
                minusButton.activateButton()
            }
                updateNextButtonState()
            if number > 98 {
//                showWarningToastView(duration: 2.0)
                plusButton.disabledButton()
            }
        }
    }
    
    @objc func minusButtonTapped() {
        print("눌렸어염")
        if let text = recruitTextField.text, var number = Int(text) {
            number -= 1
            recruitTextField.text = "\(number)"
            if number < 2 {
                minusButton.disabledButton()
            }
            updateNextButtonState()
            if number < 99 {
                plusButton.activateButton()
            }
        }
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if let text = recruitTextField.text, var number = Int(text) {
            if number < 2 {
                minusButton.disabledButton()
            } else if number > 1 {
                minusButton.activateButton()
            }
            
            if number > 98 {
                plusButton.disabledButton()
            } else if number < 99 {
                plusButton.activateButton()
            }
        }
    }
    
    @objc func nextButtonTapped() {
        print("여기 누르면 오카방 어쩌구로 넘어감")
    }
    
    @objc func exitButtonTapped() {
        print("나가기 모달 나오세요")
    }
    
    // MARK: Function
    func setTarget() {
        recruitTextField.addTarget(self,
                action:#selector(self.textFieldDidChange(_:)), for: .editingChanged)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setInitialNum() {
        recruitTextField.text = "1"
        updateNextButtonState()
    }
    
    func updateNextButtonState() {
        if let text = recruitTextField.text, let number = Int(text), number > 1 {
            nextButton.activateButton()
        } else {
            nextButton.disabledButton()
        }
    }
    
    override func setDelegate() {
        self.recruitTextField.delegate = self
    }
}

// MARK: Extension
//extension RecruitmentViewController {
//    func showWarningToastView(duration: TimeInterval = 2.0) {
//        self.warningToastView.fadeIn()
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            self.warningToastView.fadeOut()
//        }
//    }
//}
// MARK: UITextFieldDelegate
extension RecruitmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

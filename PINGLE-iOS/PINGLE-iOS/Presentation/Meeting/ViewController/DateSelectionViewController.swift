//
//  DateSelectionViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/6/24.
//

import UIKit

import SnapKit
import Then

class DateSelectionViewController: BaseViewController {
    // MARK: - Property
    private let backButton = UIButton()
    private let progressBar3 = UIImageView()
    private let dateSelectionTitle = UILabel()
    private let PINGLEDateSelectionTextField = PINGLETextFieldView(
        titleLabel: StringLiterals.Meeting.DateSelection.PINGLEDateTitle,
        explainLabel: StringLiterals.Meeting.DateSelection.PINGLEDatePlaceholder)
    private let PINGLETStartTimeTextField = PINGLETextFieldView(
        titleLabel: StringLiterals.Meeting.DateSelection.PINGLEStartTime,
        explainLabel: StringLiterals.Meeting.DateSelection.PINGLETimePlacsholder)
    private let PINGLEEndTimeTextField = PINGLETextFieldView(
        titleLabel: StringLiterals.Meeting.DateSelection.PINGLEEndTime,
        explainLabel: StringLiterals.Meeting.DateSelection.PINGLETimePlacsholder)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    private let bottomDateView = CustomDatePickerView()
    private let bottomStartTimeView = CustomTimePickerView()
    private let bottomEndTimeView = CustomTimePickerView()
    private let formatter = DateFormatter()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setDelegate()
        setTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigation()
    }
    
    // MARK: - UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Metting.Icon.icBack, for: .normal)
        }
        
        progressBar3.do {
            $0.image = ImageLiterals.Metting.ProgressBar.progressBarImage3
            $0.contentMode = .scaleAspectFill
        }
        
        dateSelectionTitle.do {
            $0.text = StringLiterals.Meeting.DateSelection.dateSelecionTitle
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        exitLabel.do {
            $0.text = StringLiterals.Meeting.MeetingCategory.ExitButton.exitLabel
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG06
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, progressBar3,
                              dateSelectionTitle, PINGLEDateSelectionTextField,
                              PINGLETStartTimeTextField, PINGLEEndTimeTextField,
                              nextButton, exitLabel, exitButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar3.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateSelectionTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        PINGLEDateSelectionTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(200.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        PINGLETStartTimeTextField.snp.remakeConstraints {
            $0.top.equalTo(PINGLEDateSelectionTextField.snp.bottom).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
            $0.trailing.equalToSuperview().inset(192.adjusted)
        }
        
        PINGLEEndTimeTextField.snp.remakeConstraints {
            $0.top.equalTo(PINGLEDateSelectionTextField.snp.bottom).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(192.adjusted)
            $0.trailing.equalToSuperview().inset(24.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).inset(54.adjusted)
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
    
    @objc func textFieldDidChange(_ sender: Any?) {
        if let textField = sender as? UITextField {
            if let newText = textField.text, !newText.isEmpty {
                nextButton.activateButton()
            } else {
                nextButton.disabledButton()
            }
        }
    }
    
    @objc func showDatePicker() {
        print("데이트피커 올라오셈")
        bottomDateView.frame.origin.y = view.frame.height
        setBottomSheetLayout()
        UIView.animate(withDuration: 0.5) {
            self.bottomDateView.frame.origin.y = self.view.frame.height - self.bottomDateView.frame.height
        }
    }
    
    @objc func showStartTimePicker() {
        print("시작타임피커 올라오셈")
        bottomStartTimeView.frame.origin.y = view.frame.height
        setStartTimeViewLayout()
        UIView.animate(withDuration: 0.5) {
            self.bottomStartTimeView.frame.origin.y = self.view.frame.height - self.bottomStartTimeView.frame.height
        }
    }
    
    @objc func showEndTimePicker() {
        print("종료타임피커 올라오셈")
        bottomEndTimeView.frame.origin.y = view.frame.height
        setEndTimeViewLayout()
        UIView.animate(withDuration: 0.5) {
            self.bottomEndTimeView.frame.origin.y = self.view.frame.height - self.bottomEndTimeView.frame.height
        }
    }
    
    @objc func doneButtonTapped() {
        PINGLEDateSelectionTextField.searchTextField.text =
        dateFormat(date: bottomDateView.datePicker.date)
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomDateView.removeFromSuperview()
        })
    }
    
    @objc func startTimeDoneButtonTapped() {
        PINGLETStartTimeTextField.searchTextField.text =
        timeFormat(time: bottomStartTimeView.timePicker.date)
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomStartTimeView.removeFromSuperview()
        })
    }
    
    @objc func endTimeDoneButtonTapped() {
        let selectedStartTime = bottomStartTimeView.timePicker.date
        let selectedEndTime = bottomEndTimeView.timePicker.date

        if selectedEndTime > selectedStartTime {
            PINGLEEndTimeTextField.searchTextField.text = timeFormat(time: selectedEndTime)
            UIView.animate(withDuration: 0.5, animations: {
                self.bottomEndTimeView.removeFromSuperview()
            })
            nextButton.activateButton()
        } else {
            print("Error: End time should be after start time")
            nextButton.disabledButton()
        }
    }
    
    @objc func nextButtonTapped() {
        let placeSelectionViewController = PlaceSelectionViewController()
        navigationController?.pushViewController(placeSelectionViewController, animated: true)
        }
    
    @objc func exitButtonTapped() {
        print("여기다가 나가기 모달 띄우기")
    }

    // MARK: Function
    private func setTarget() {
        PINGLEDateSelectionTextField.searchTextField.addTarget(self,
                action:#selector(self.textFieldDidChange(_:)), for: .editingChanged)
        PINGLEDateSelectionTextField.searchTextField.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        PINGLETStartTimeTextField.searchTextField.addTarget(self,
                action:#selector(self.textFieldDidChange(_:)), for: .editingChanged)
        PINGLETStartTimeTextField.searchTextField.addTarget(self, action: #selector(showStartTimePicker), for: .touchUpInside)
        PINGLEEndTimeTextField.searchTextField.addTarget(self,
                action:#selector(self.textFieldDidChange(_:)), for: .editingChanged)
        PINGLEEndTimeTextField.searchTextField.addTarget(self, action: #selector(showEndTimePicker), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped),
                             for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), 
                             for: .touchUpInside)
        bottomDateView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        bottomStartTimeView.doneButton.addTarget(self, action: #selector(startTimeDoneButtonTapped), for: .touchUpInside)
        bottomEndTimeView.doneButton.addTarget(self, action: #selector(endTimeDoneButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == PINGLEDateSelectionTextField.searchTextField {
            showDatePicker()
        } else if textField == PINGLETStartTimeTextField.searchTextField {
            showStartTimePicker()
        } else if textField == PINGLEEndTimeTextField.searchTextField {
            showEndTimePicker()
        }
        return true
    }

    private func dateFormat(date: Date) -> String {
        formatter.dateFormat = "yyyy / MM / dd"
        return formatter.string(from: date)
    }
    
    private func timeFormat(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: time)
    }
    
    private func setBottomSheetLayout() {
        view.addSubview(bottomDateView)
        
        bottomDateView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(295.adjusted)
            $0.bottom.equalToSuperview().inset(41.adjusted)
        }
    }  
    
    private func setStartTimeViewLayout() {
        view.addSubview(bottomStartTimeView)
        
        bottomStartTimeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(295.adjusted)
            $0.bottom.equalToSuperview().inset(41.adjusted)
        }
    }
    
    private func setEndTimeViewLayout() {
        view.addSubview(bottomEndTimeView)
        
        bottomEndTimeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(295.adjusted)
            $0.bottom.equalToSuperview().inset(41.adjusted)
        }
    }

    override func setDelegate() {
        self.PINGLEDateSelectionTextField.searchTextField.delegate = self
        self.PINGLETStartTimeTextField.searchTextField.delegate = self
        self.PINGLEEndTimeTextField.searchTextField.delegate = self
    }
}

// MARK: Extension
// MARK: UITextFieldDelegate
extension DateSelectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

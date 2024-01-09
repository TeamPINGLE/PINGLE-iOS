//
//  CustomDatePickerView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/6/24.
//

import UIKit

import SnapKit
import Then

class CustomDatePickerView: BaseView {
    // MARK: - Property
    let datePicker = UIDatePicker()
    let resetButton = UIButton()
    let doneButton = UIButton()
    private let dividerView = UIView()
    private let nowDate = Date()
    
    // MARK: - UI
    override func setStyle() {
        self.do {
            $0.makeCornerRound(radius: 13.adjusted)
            $0.backgroundColor = .grayscaleG10
        }
        
        datePicker.do {
            $0.datePickerMode = .date
            $0.preferredDatePickerStyle = .wheels
            $0.setValue(UIColor.white, forKey: "textColor")
            $0.minimumDate = nowDate
        }
        
        dividerView.do {
            $0.backgroundColor = .white
            $0.alpha = 0.3
        }
        
        resetButton.do {
            $0.setTitle(StringLiterals.Meeting.DatePicker.PickerButton.resetButton, for: .normal)
            $0.titleLabel?.font = .sfProRegular
            $0.setTitleColor(.systemBlue, for: .normal)
        }
        
        doneButton.do {
            $0.setTitle(StringLiterals.Meeting.DatePicker.PickerButton.doneButton, for: .normal)
            $0.titleLabel?.font = .sfProBold
            $0.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    override func setLayout() {
        self.addSubviews(datePicker, dividerView, resetButton, doneButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(288)
            $0.width.equalTo(327)
        }
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(15.adjusted)
            $0.bottom.equalToSuperview().inset(60.adjusted)
        }
        
        dividerView.snp.makeConstraints {
            $0.width.equalTo(307.adjusted)
            $0.height.equalTo(1.adjusted)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(datePicker.snp.bottom).offset(15.adjusted)
        }
        
        resetButton.snp.makeConstraints {
            $0.width.equalTo(43.adjusted)
            $0.height.equalTo(24.adjusted)
            $0.leading.equalToSuperview().inset(23.adjusted)
            $0.top.equalTo(dividerView.snp.bottom).offset(10.adjusted)
        }
        
        doneButton.snp.makeConstraints {
            $0.width.equalTo(42.adjusted)
            $0.height.equalTo(24.adjusted)
            $0.trailing.equalToSuperview().inset(23.adjusted)
            $0.top.equalTo(dividerView.snp.bottom).offset(10.adjusted)
        }
    }
}

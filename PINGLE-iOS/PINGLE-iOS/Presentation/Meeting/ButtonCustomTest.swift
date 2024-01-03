//
//  ButtonCustomTest.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//
import UIKit

import Then
import SnapKit

class ButtonCustomTest: BaseViewController {
// MARK: Property
    let testButton = CustomButton(title: "핑글 개최하러 가기", buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    let textField = UITextField().then {
        $0.placeholder = "아무거나 적어보셈..."
        $0.borderStyle = .roundedRect
    }

// MARK: - UI
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
    }
    
    override func setLayout() {
        view.addSubviews(testButton, textField)
        
        testButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(50)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom).offset(20)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.width.equalTo(200)
        }
        
        textField.delegate = self
    }
}

// MARK: - UITextFieldDelegate Extension

extension ButtonCustomTest: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            if newText.isEmpty {
                testButton.disabledButton()
            } else {
                testButton.activateButton()
            }
        }
        return true
    }
}

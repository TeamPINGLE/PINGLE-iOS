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
    let testButton = PINGLECTAButton(title: "핑글 개최하러 가기", buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    let categoryTestButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Metting.MettingCategory.CategoryTitle.play,
                                                  buttonExplainLabel: StringLiterals.Metting.MettingCategory.ExplainCategory.playExplain,
                                                  category: ImageLiterals.Metting.Category.categoryPlayImage, textColor: .mainPingleGreen)
    
    let exitButton = MeetingExitButton()
    
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
        view.addSubview(categoryTestButton)
        view.addSubview(exitButton)
        
        testButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(50)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom).offset(20)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.width.equalTo(200)
        }
        
        categoryTestButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(50)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(categoryTestButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(50)
        }
        
        textField.delegate = self
        testButton.addTarget(self, action: #selector(testButtonPressed), for: .touchUpInside)
        categoryTestButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
    }
    
    @objc func categorySelected() {
        categoryTestButton.selectedButton()
        print("카테고리가 선택되었습니다.")
    }
    
    @objc func testButtonPressed() {
            print("버튼이 눌렸습니다.")
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

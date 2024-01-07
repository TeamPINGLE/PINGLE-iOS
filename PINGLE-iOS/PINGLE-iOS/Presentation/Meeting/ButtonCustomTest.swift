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
    
    let categoryTestButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Meeting.MeetingCategory.CategoryTitle.play,
                                                  buttonExplainLabel: StringLiterals.Meeting.MeetingCategory.ExplainCategory.playExplain,
                                                  category: ImageLiterals.Metting.Category.categoryPlayImage, textColor: .mainPingleGreen)
    
    let exitButton = MeetingExitButton()
    
    let testView = CustomDatePickerView()
    
    let exitModal = ExitModalView()

// MARK: - UI
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
    }
    
    override func setLayout() {
        view.addSubview(exitModal)

        exitModal.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

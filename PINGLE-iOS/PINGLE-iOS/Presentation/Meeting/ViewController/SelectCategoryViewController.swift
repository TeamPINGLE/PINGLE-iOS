//
//  SelectCategoryViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/4/24.
//

import UIKit

import SnapKit
import Then

class SelectCategoryViewController: BaseViewController {
    // MARK: Property
    private let backButton = UIButton()
    private let progressBar1 = UIImageView()
    private let categoryTitle = UILabel()
    private let playButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Metting.MettingCategory.CategoryTitle.play,
                                                  buttonExplainLabel: StringLiterals.Metting.MettingCategory.ExplainCategory.playExplain,
                                                  category: ImageLiterals.Metting.Category.categoryPlayImage,
                                                  textColor: .mainPingleGreen)
    private let studyButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Metting.MettingCategory.CategoryTitle.study,
                                                  buttonExplainLabel: StringLiterals.Metting.MettingCategory.ExplainCategory.studyExplain,
                                                  category: ImageLiterals.Metting.Category.categoryStudyImage,
                                                   textColor: .subPingleOrange)
    private let multiButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Metting.MettingCategory.CategoryTitle.multi,
                                                  buttonExplainLabel: StringLiterals.Metting.MettingCategory.ExplainCategory.multiExplain,
                                                  category: ImageLiterals.Metting.Category.categoryMultiImage,
                                                   textColor: .subPingleYellow)
    private let othersButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Metting.MettingCategory.CategoryTitle.others,
                                                  buttonExplainLabel: StringLiterals.Metting.MettingCategory.ExplainCategory.othersExplain,
                                                  category: ImageLiterals.Metting.Category.categoryPlayImage,
                                                    textColor: .grayscaleG10)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle, 
        buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
}

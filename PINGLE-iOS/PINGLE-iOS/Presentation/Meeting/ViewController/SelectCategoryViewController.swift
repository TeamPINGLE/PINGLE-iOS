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
    private let PINGLECategoryTitle = UILabel()
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
                                                    textColor: .white)
    private let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .black
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Metting.Icon.icBack, for: .normal)
        }
        progressBar1.do {
            $0.image = ImageLiterals.Metting.ProgressBar.progressBarImage1
            $0.contentMode = .scaleAspectFit
        }
        
        PINGLECategoryTitle.do {
            $0.text = StringLiterals.Metting.MettingCategory.CategoryLabel.categoryTitleLabel
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
        self.view.addSubviews(backButton, progressBar1, PINGLECategoryTitle, 
                              playButton, studyButton, multiButton, othersButton,
                              nextButton, exitLabel, exitButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar1.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        PINGLECategoryTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        playButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(202.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        studyButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(202.adjusted)
            $0.leading.equalToSuperview().inset(192.adjusted)
        }
        
        multiButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(349.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        othersButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(349.adjusted)
            $0.leading.equalToSuperview().inset(192.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(507.adjusted)
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
    @objc func categorySelected(sender: PINGLECategoryButton) {
        unselectAllButtons()
        sender.selectedButton()
        switch sender {
        case playButton:
            print("playButton이 선택되었습니다.")
            nextButton.activateButton()
        case studyButton:
            print("studyButton가 선택되었습니다.")
            nextButton.activateButton()
        case multiButton:
            print("multiButton이 선택되었습니다.")
            nextButton.activateButton()
        case othersButton:
            print("othersButton가 선택되었습니다.")
            nextButton.activateButton()
        default:
            break
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        print("여기다가 다음 뷰컨 연결 할것임")
    }
    
    // MARK: - Function
    func unselectAllButtons() {
        playButton.nonSelectedButton()
        studyButton.nonSelectedButton()
        multiButton.nonSelectedButton()
        othersButton.nonSelectedButton()
    }
    
    func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        studyButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        multiButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        othersButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
}

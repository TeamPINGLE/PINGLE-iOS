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
    
    // MARK: - Property
    private let backButton = UIButton()
    private let progressBar1 = UIImageView()
    private let PINGLECategoryTitle = UILabel()
    private let playButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Meeting.MeetingCategory.CategoryTitle.play,
                                                  buttonExplainLabel: StringLiterals.Meeting.MeetingCategory.ExplainCategory.playExplain,
                                                  category: UIImage(resource: .graphicPlay),
                                                  textColor: .mainPingleGreen)
    private let studyButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Meeting.MeetingCategory.CategoryTitle.study,
                                                   buttonExplainLabel: StringLiterals.Meeting.MeetingCategory.ExplainCategory.studyExplain,
                                                   category: UIImage(resource: .graphicStudy),
                                                   textColor: .subPingleOrange)
    private let multiButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Meeting.MeetingCategory.CategoryTitle.multi,
                                                   buttonExplainLabel: StringLiterals.Meeting.MeetingCategory.ExplainCategory.multiExplain,
                                                   category: UIImage(resource: .graphicMulti),
                                                   textColor: .subPingleYellow)
    private let othersButton = PINGLECategoryButton(buttonTitleLabel: StringLiterals.Meeting.MeetingCategory.CategoryTitle.others,
                                                    buttonExplainLabel: StringLiterals.Meeting.MeetingCategory.ExplainCategory.othersExplain,
                                                    category: UIImage(resource: .graphicOthers),
                                                    textColor: .white)
    let nextButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle,
                                             buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    private let exitLabel = UILabel()
    private let exitButton = MeetingExitButton()
    private let exitModal = ExitModalView()
    private let dimmedView = UIView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDimmedView()
        setNavigation()
        setTarget()
        setGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigation()
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
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        progressBar1.do {
            $0.image = UIImage(resource: .imgProgressBar1)
            $0.contentMode = .scaleAspectFill
        }
        
        playButton.do {
            $0.contentMode = .scaleAspectFit
        }
        
        studyButton.do {
            $0.contentMode = .scaleAspectFit
        }
        
        multiButton.do {
            $0.contentMode = .scaleAspectFit
        }
        
        othersButton.do {
            $0.contentMode = .scaleAspectFit
        }
        
        PINGLECategoryTitle.do {
            $0.text = StringLiterals.Meeting.MeetingCategory.CategoryLabel.categoryTitleLabel
            $0.setLineSpacing(spacing: 4)
            $0.textAlignment = .left
            $0.font = .titleTitleSemi24
            $0.numberOfLines = 0
            $0.textColor = .white
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
        self.view.addSubviews(backButton, progressBar1, PINGLECategoryTitle, 
                              playButton, studyButton, multiButton, othersButton,
                              nextButton, exitLabel, exitButton, dimmedView)
        
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
            $0.top.equalTo(progressBar1.snp.bottom).offset(28.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        playButton.snp.makeConstraints {
            $0.top.equalTo(PINGLECategoryTitle.snp.bottom).offset(28.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        studyButton.snp.makeConstraints {
            $0.top.equalTo(PINGLECategoryTitle.snp.bottom).offset(28.adjusted)
            $0.leading.equalToSuperview().inset(192.adjusted)
        }
        
        multiButton.snp.makeConstraints {
            $0.top.equalTo(playButton.snp.bottom).offset(12.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        othersButton.snp.makeConstraints {
            $0.top.equalTo(studyButton.snp.bottom).offset(12.adjusted)
            $0.leading.equalToSuperview().inset(192.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(exitLabel.snp.top).offset(-14.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
        
        exitLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-23.adjusted)
            $0.leading.equalToSuperview().inset(118.adjusted)
            $0.trailing.equalToSuperview().inset(153.adjusted)
        }
        
        exitButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-23.adjusted)
            $0.leading.equalTo(exitLabel.snp.trailing).offset(4.adjusted)
            $0.centerY.equalTo(exitLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(117.adjusted)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Objc Function
    @objc func categorySelected(sender: PINGLECategoryButton) {
        unselectAllButtons()
        sender.selectedButton()
        switch sender {
        case playButton:
            nextButton.activateButton()
            MeetingManager.shared.category = StringLiterals.Meeting.MeetingCategory.CategoryTitle.play
        case studyButton:
            nextButton.activateButton()
            MeetingManager.shared.category = StringLiterals.Meeting.MeetingCategory.CategoryTitle.study
        case multiButton:
            nextButton.activateButton()
            MeetingManager.shared.category = StringLiterals.Meeting.MeetingCategory.CategoryTitle.multi
        case othersButton:
            nextButton.activateButton()
            MeetingManager.shared.category = StringLiterals.Meeting.MeetingCategory.CategoryTitle.others
        default:
            break
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        unselectAllButtons()
        nextButton.disabledButton()
    }
    
    @objc func nextButtonTapped() {
        let meetingIntroductionViewController = MeetingIntroductionViewController()
        navigationController?.pushViewController(meetingIntroductionViewController, animated: true)
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
        AmplitudeInstance.shared.track(eventType: .clickStep1CancelStay)
        exitModal.isHidden = true
        exitModal.removeFromSuperview()
        dimmedView.isHidden = true
    }
    
    @objc func exitModalExitButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickStep1CancelOut)
        exitModal.isHidden = true
        dimmedView.isHidden = true
        self.dismiss(animated: true) {
            if let tabBarController = self.tabBarController {
                if tabBarController.viewControllers?.count ?? 0 >= 2 {
                    tabBarController.selectedIndex = 0
                }
            }
        }
    }
    
    @objc func dimmedViewTapped() {
        hideDimmedViewWhenTapped()
    }
    
    // MARK: - Function
    func unselectAllButtons() {
        playButton.nonSelectedButton()
        studyButton.nonSelectedButton()
        multiButton.nonSelectedButton()
        othersButton.nonSelectedButton()
    }
    
    private func setUpDimmedView() {
        dimmedView.isHidden = true
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        studyButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        multiButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        othersButton.addTarget(self, action: #selector(categorySelected), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitModal.exitButton.addTarget(self, action: #selector(exitModalExitButtonTapped), for: .touchUpInside)
        exitModal.keepMaking.addTarget(self, action: #selector(exitModalKeepButtonTapped), for: .touchUpInside)
        
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    private func hideDimmedViewWhenTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.dimmedView.isHidden = true
        })
        exitModal.isHidden = true
    }
}

// MARK: - Extension
extension SelectCategoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

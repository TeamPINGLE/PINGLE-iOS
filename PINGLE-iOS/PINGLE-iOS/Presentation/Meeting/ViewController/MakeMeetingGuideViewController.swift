//
//  MakeMettingGuideViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class MakeMeetingGuideViewController: BaseViewController {
    
    // MARK: Property
    private let meetingImageView = UIImageView()
    private let exitButton = UIButton()
    private let guideTitle = UILabel()
    private let guideSubTitle = UILabel()
    private let entranceButton = PINGLECTAButton(title: StringLiterals.Meeting.MeetingGuide.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    let selectCategoryViewController = SelectCategoryViewController()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setNavigation()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.backgroundColor = .grayscaleG11
        
        self.meetingImageView.do {
            $0.image = UIImage(resource: .graphicIntro)
            $0.contentMode = .scaleAspectFill
        }
        
        self.exitButton.do {
            $0.setImage(UIImage(resource: .imgExitButton), for: .normal)
            $0.contentMode = .scaleAspectFill
        }
        
        self.guideTitle.do {
            $0.text = StringLiterals.Meeting.MeetingGuide.guideTitle
            $0.setLineSpacing(spacing: 5)
            $0.font = .titleTitleSemi32
            $0.textAlignment = .left
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        self.guideSubTitle.do {
            $0.text = StringLiterals.Meeting.MeetingGuide.guideSubTitle
            $0.setLineSpacing(spacing: 5)
            $0.font = .bodyBodyMed16
            $0.textAlignment = .left
            $0.numberOfLines = 2
            $0.textColor = .grayscaleG04
            $0.asColorArray(targetStringList: ["PIN", "MINGLE"], color: .mainPingleGreen)
        }
        
        self.entranceButton.do {
            $0.activateButton()
        }
    }
    
    override func setLayout() {
        view.addSubviews(exitButton, meetingImageView, guideTitle, guideSubTitle, entranceButton)
        
        exitButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60.adjusted)
            $0.leading.equalToSuperview().inset(333.adjusted)
        }
        
        guideTitle.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        guideSubTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(238)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        if UIScreen.main.bounds.height > 667 {
            meetingImageView.snp.makeConstraints {
                $0.trailing.equalToSuperview()
                $0.top.equalToSuperview().inset(177)
                $0.width.equalTo(509)
                $0.bottom.equalTo(entranceButton.snp.top).offset(-25)
            }
        } else {
            meetingImageView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().inset(196)
                $0.bottom.equalTo(entranceButton.snp.top).offset(-25)
            }
        }
        
        entranceButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).inset(54.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
    }
    
    // MARK: Target Function
    private func setTarget() {
        entranceButton.addTarget(self, action: #selector(entranceButtonPressed), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Objc Function
    @objc func entranceButtonPressed() {
        AmplitudeInstance.shared.track(eventType: .startMeetingHold)
        selectCategoryViewController.unselectAllButtons()
        selectCategoryViewController.nextButton.disabledButton()
        navigationController?.pushViewController(selectCategoryViewController, animated: true)
        }
    
    @objc func exitButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickMeetingCancel)
        self.presentingViewController?.dismiss(animated: true)
    }
}

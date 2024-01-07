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
    private let mettingImageView = UIImageView()
    private let exitButton = UIButton()
    private let guideTitle = UILabel()
    private let guideSubTitle = UILabel()
    private let entranceButton = PINGLECTAButton(title: StringLiterals.Meeting.MeetingGuide.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.backgroundColor = .grayscaleG11
        
        self.mettingImageView.do {
            $0.image = ImageLiterals.Metting.Guide.imgMettingGraphic
            $0.contentMode = .scaleAspectFit
        }
        
        self.exitButton.do {
            $0.setImage(ImageLiterals.Metting.Guide.imgExitButton, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        self.guideTitle.do {
            $0.text = StringLiterals.Meeting.MeetingGuide.guideTitle
            $0.font = .titleTitleSemi32
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        self.guideSubTitle.do {
            $0.text = StringLiterals.Meeting.MeetingGuide.guideSubTitle
            $0.font = .subtitleSubSemi16
            $0.textColor = .white
            $0.numberOfLines = 2
        }
        
        self.entranceButton.do {
            $0.activateButton()
        }
    }
    
    override func setLayout() {
        view.addSubviews(exitButton, mettingImageView, guideTitle, guideSubTitle, entranceButton)
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(333.adjusted)
        }
        
        mettingImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(133.adjusted)
        }
        
        guideTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(88.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        guideSubTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(194.adjusted)
            $0.leading.equalToSuperview().inset(24.adjusted)
        }
        
        entranceButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).inset(54.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
    }
    
    // MARK: Target Function
    private func setTarget() {
        entranceButton.addTarget(self, action: #selector(entranceButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func entranceButtonPressed() {
        let selectCategoyViewController = SelectCategoryViewController()
        navigationController?.pushViewController(selectCategoyViewController, animated: true)
        }
}

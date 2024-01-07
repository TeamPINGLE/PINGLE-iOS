//
//  ExitModalView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/7/24.
//

import UIKit

import SnapKit
import Then

class ExitModalView: BaseView {
    
    // MARK: - Property
    private let exitQuestion = UILabel()
    private let exitWarning = UILabel()
    let keepMaking = UIButton()
    let exitButton = MeetingExitButton()
    
    // MARK: - UI
    override func setStyle() {
        self.do {
            $0.makeCornerRound(radius: 15.adjusted)
            $0.backgroundColor = .grayscaleG10
        }
        
        exitQuestion.do {
            $0.text = StringLiterals.Meeting.ExitModalView.exitQuestion
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        exitWarning.do {
            $0.text = StringLiterals.Meeting.ExitModalView.exitWarning
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG05
        }
        
        keepMaking.do {
            $0.setTitle(StringLiterals.Meeting.ExitModalView.continueMaking, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
            $0.makeCornerRound(radius: 10.adjusted)
            $0.backgroundColor = .grayscaleG01
        }
    }
    
    override func setLayout() {
        self.addSubviews(exitQuestion, exitWarning, keepMaking, exitButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(232.adjusted)
            $0.width.equalTo(327.adjusted)
        }
        
        exitQuestion.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(90.adjusted)
            $0.top.equalToSuperview().inset(46.adjusted)
            $0.bottom.equalToSuperview().inset(161.adjusted)
        }
        
        exitWarning.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(59.adjusted)
            $0.top.equalToSuperview().inset(75.adjusted)
            $0.bottom.equalToSuperview().inset(137.adjusted)
        }
        
        keepMaking.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(71.adjusted)
            $0.top.equalToSuperview().inset(130.adjusted)
            $0.bottom.equalToSuperview().inset(58.adjusted)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(186.adjusted)
            $0.bottom.equalToSuperview().inset(29.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
}

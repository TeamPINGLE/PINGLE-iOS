//
//  AccountPopUpView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/7/24.
//

import UIKit

import SnapKit
import Then

enum AccountState {
    case logout
    case delete
}

final class AccountPopUpView: BaseView {
    
    // MARK: Property
    private let questionLabel = UILabel()
    private let explanationLabel = UILabel()
    let backButton = UIButton()
    let changeStateButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        self.questionLabel.do {
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
        
        self.explanationLabel.do {
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG05
        }
        
        self.backButton.do {
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .grayscaleG01
            $0.setTitle(StringLiterals.Profile.ButtonTitle.backTitle, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
        }
        
        self.changeStateButton.do {
            //            $changeStateButton.setTitle(StringLiterals.Profile.ButtonTitle.logoutTitle, for: .normal)
            $0.titleLabel?.font = .captionCapSemi12
            $0.setTitleColor(.grayscaleG01, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder([.bottom], color: .grayscaleG01, width: 1.0, frameHeight: 17.0.adjusted, framgeWidth: 42.0.adjusted)
        }
    }
    
    override func setLayout() {
        self.addSubviews(questionLabel, explanationLabel, backButton,
                         changeStateButton)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width - 48)
            $0.height.equalTo(232.adjusted)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(46.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(self.questionLabel.snp.bottom).offset(4.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.explanationLabel.snp.bottom).offset(35.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(185.adjustedWidth)
            $0.height.equalTo(44.adjusted)
        }
        
        changeStateButton.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(12.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17.adjusted)
            $0.width.equalTo(42.adjusted)
        }
    }
    
    // MARK: SetAccountStateMode
    func SetAccountStateMode(state: AccountState) {
        switch state {
        case .logout:
            questionLabel.text = StringLiterals.Profile.ExplainTitle.logoutQuestionTitle
            explanationLabel.text = StringLiterals.Profile.ExplainTitle.logoutExplanation
            changeStateButton.setTitle(StringLiterals.Profile.ButtonTitle.logoutTitle, for: .normal)
        case .delete:
            changeStateButton.setTitle(StringLiterals.Profile.ButtonTitle.deleteTitle, for: .normal)
            questionLabel.text = StringLiterals.Profile.ExplainTitle.deleteQuestionTitle
            explanationLabel.text = StringLiterals.Profile.ExplainTitle.deleteExplanation
        }
    }
}

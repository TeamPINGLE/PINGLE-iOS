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
        
        questionLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 25)
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
            $0.numberOfLines = 3
            $0.lineBreakMode = .byTruncatingTail
        }
        
        explanationLabel.do {
            $0.font = .bodyBodyMed14
            $0.textColor = .grayscaleG05
        }
        
        backButton.do {
            $0.makeCornerRound(radius: 10)
            $0.backgroundColor = .grayscaleG01
            $0.setTitle(StringLiterals.Profile.ButtonTitle.backTitle, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .bodyBodySemi14
        }
        
        changeStateButton.do {
            $0.titleLabel?.font = .captionCapSemi12
            $0.setTitleColor(.grayscaleG01, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder(
                [.bottom],
                color: .grayscaleG01,
                width: 1.0,
                frameHeight: 17.0,
                framgeWidth: 42.0
            )
        }
    }
    
    override func setLayout() {
        addSubviews(questionLabel, 
                    explanationLabel,
                    backButton,
                    changeStateButton)
        
        snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width - 48.adjusted)
            $0.height.equalTo(232)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(49)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        explanationLabel.snp.makeConstraints {
            $0.top.equalTo(self.questionLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(58)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(185)
            $0.height.equalTo(44)
        }
        
        changeStateButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(29)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
            $0.width.equalTo(42)
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
    
    //MARK: Change Popup Function
    func makeChangingOrganizationPopUp(organizationName: String) {
        backButton.setTitle(StringLiterals.Profile.ButtonTitle.changeTitle, for: .normal)
        changeStateButton.setTitle(StringLiterals.Profile.ButtonTitle.backTitle, for: .normal)
        explanationLabel.isHidden = true
        
        if organizationName.count > 12 {
            let endIndex = organizationName.index(organizationName.startIndex, offsetBy: 12)
            let truncatedString = organizationName[..<endIndex] + "・・・"
            
            questionLabel.text = "'\(truncatedString)'" + StringLiterals.Profile.ExplainTitle.questionChangeOrganization
        } else {
            questionLabel.text = "'\(organizationName)'" + StringLiterals.Profile.ExplainTitle.questionChangeOrganization
        }
        
        questionLabel.layoutIfNeeded()
        
        let viewHeight = 183 + min(questionLabel.countCurrentLines(), 3) * 25
        
        self.snp.updateConstraints {
            $0.height.equalTo(viewHeight)
        }
    }
}

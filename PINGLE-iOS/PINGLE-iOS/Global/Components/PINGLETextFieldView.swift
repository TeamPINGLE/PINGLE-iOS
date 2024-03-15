//
//  PINGLETextFieldView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/4/24.
//

import UIKit

import SnapKit
import Then

final class PINGLETextFieldView: BaseView {

    // MARK: Property
    private let titleLabel = UILabel()
    let searchTextField = UITextField()
    let duplicationCheckButton = UIButton()
    private let clipBoardCopyImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(titleLabel: String, explainLabel: String) {
        super.init(frame: .zero)
        self.titleLabel.text = titleLabel
        self.searchTextField.attributedPlaceholder = NSAttributedString(
            string: explainLabel,
            attributes: [
                .font: UIFont.bodyBodyMed16,
                .foregroundColor: UIColor.grayscaleG07
            ]
        )
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 12.adjusted
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
        
        titleLabel.do {
            $0.font = .captionCapSemi12
            $0.textColor = .grayscaleG03
        }
        
        searchTextField.do {
            $0.font = .subtitleSubSemi16
            $0.textColor = .white
            $0.tintColor = .mainPingleGreen
            $0.returnKeyType = .done
            $0.enablesReturnKeyAutomatically = true
        }
        
        duplicationCheckButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.duplicationCheck, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .captionCapSemi10
            $0.backgroundColor = .grayscaleG08
            $0.makeCornerRound(radius: 10)
            $0.isHidden = true
            $0.isEnabled = false
        }
    }
    
    override func setLayout() {
        addSubviews(titleLabel,
                    searchTextField,
                    duplicationCheckButton)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width-48)
            $0.height.equalTo(75)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(18)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        duplicationCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.trailing.equalToSuperview().inset(18)
            $0.width.equalTo(58)
            $0.height.equalTo(20)
        }
    }
    
    func makeCheckForDuplicationButton() {
        searchTextField.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(18)
            $0.trailing.equalToSuperview().inset(84)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        duplicationCheckButton.isHidden = false
    }
    
    func possibleDuplicationButton() {
        duplicationCheckButton.isEnabled = true
        duplicationCheckButton.backgroundColor = .grayscaleG02
    }
    
    func impossibleDuplicationButton() {
        duplicationCheckButton.isEnabled = false
        duplicationCheckButton.backgroundColor = .grayscaleG08
    }
    
    func makeClipBoardCopyImageView() {
        /// set Style
        clipBoardCopyImageView.do {
            $0.image = UIImage(resource: .icCopy)
            $0.tintColor = .grayscaleG04
        }
        
        /// set Layout
        addSubview(clipBoardCopyImageView)
        clipBoardCopyImageView.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.trailing.equalToSuperview().inset(18)
            $0.size.equalTo(24)
        }
    }
}

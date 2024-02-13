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
    }
    
    override func setLayout() {
        addSubviews(titleLabel, searchTextField)
        
        self.snp.makeConstraints {
            $0.width.equalTo(327.adjustedWidth)
            $0.height.equalTo(75.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.adjusted)
            $0.leading.equalToSuperview().offset(18.adjusted)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.adjusted)
            $0.leading.trailing.equalToSuperview().inset(18.adjusted)
            $0.bottom.equalToSuperview().inset(16.adjusted)
        }
    }
}

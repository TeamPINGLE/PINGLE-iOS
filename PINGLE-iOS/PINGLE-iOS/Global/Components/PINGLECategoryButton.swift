//
//  PINGLECategoryButton.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/4/24.
//

import UIKit

import SnapKit

final class PINGLECategoryButton: UIButton {
    // MARK: Property
    private let buttonTitleLabel = UILabel()
    private let buttonExplainLabel = UILabel()
    private let categoryImage = UIImageView()
    private var isSelectedButton: Bool = false
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(buttonTitleLabel: String, buttonExplainLabel: String, category: UIImage, textColor: UIColor) {
        super.init(frame: .zero)
        setStyle()
        setLayout()
        self.buttonTitleLabel.text = buttonTitleLabel
        self.buttonExplainLabel.text = buttonExplainLabel
        self.buttonTitleLabel.textColor = textColor
        self.categoryImage.image = category
    }

// MARK: - UI
    private func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 10.adjusted
            $0.makeBorder(width: 1.adjusted, color: .grayscaleG10)
        }
        
        buttonTitleLabel.do {
            $0.font = .subtitleSubBold18
        }
        
        buttonExplainLabel.do {
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG04
        }
    }
    
    private func setLayout() {
        self.addSubviews(categoryImage, buttonTitleLabel, buttonExplainLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(159.adjusted)
            $0.height.equalTo(135.adjusted)
        }
        
        categoryImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(53.adjusted)
            $0.trailing.equalToSuperview().inset(52.adjusted)
            $0.top.equalToSuperview().inset(14.adjusted)
            $0.bottom.equalToSuperview().inset(67.adjusted)
        }
        
        buttonTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(categoryImage.snp.bottom).offset(2.adjusted)
        }
        
        buttonExplainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonTitleLabel.snp.bottom).offset(3.adjusted)
        }
    }
}

// MARK: - extension
extension PINGLECategoryButton {
    func selectedButton() {
        if isSelectedButton {
            nonSelectedButton()
            isSelectedButton = false
        } else {
            makeBorder(width: 1.adjusted, color: .white)
            isSelectedButton = true
        }
    }

    func nonSelectedButton() {
        makeBorder(width: 1.adjusted, color: .grayscaleG10)
        isSelectedButton = false
    }
}

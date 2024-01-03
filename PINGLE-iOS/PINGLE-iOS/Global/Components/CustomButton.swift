//
//  CustomButton.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//

import UIKit

import SnapKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(title: String, buttonColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        commonInit()
        setLayout()
        backgroundColor = buttonColor
        setTitleColor(textColor, for: .normal)
        setTitle(title, for: .normal)
    }
    
    private func commonInit() {
        titleLabel?.font = .subtitleSubSemi16
        layer.cornerRadius = 10
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width-32.adjusted)
            $0.height.equalTo(58.adjusted)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

extension CustomButton {
    func activateButton() {
            backgroundColor = .white
            setTitleColor(.black, for: .normal)
    }
    
    func disabledButton() {
        backgroundColor = .grayscaleG08
        setTitleColor(.grayscaleG10, for: .normal)
    }
}

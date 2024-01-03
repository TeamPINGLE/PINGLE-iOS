//
//  CustomButton.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//

import UIKit

import SnapKit

class PINGLECTAButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(title: String, buttonColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        commonInit()
        setLayout()
        self.backgroundColor = buttonColor
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
    }
    
    private func commonInit() {
        isEnabled = false
        titleLabel?.font = .subtitleSubSemi16
        layer.cornerRadius = 10.adjusted
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width-32.adjusted)
            $0.height.equalTo(58.adjusted)
        }
    }
}

extension PINGLECTAButton {
    func activateButton() {
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        isEnabled = true
    }
    
    func disabledButton() {
        backgroundColor = .grayscaleG08
        setTitleColor(.grayscaleG10, for: .normal)
        isEnabled = false
    }
}

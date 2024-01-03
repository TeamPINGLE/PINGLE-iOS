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
    
// MARK: - Function
    private func commonInit() {
        self.isEnabled = false
        self.titleLabel?.font = .subtitleSubSemi16
        self.layer.cornerRadius = 10.adjusted
    }

// MARK: - UI
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width-32.adjusted)
            $0.height.equalTo(58.adjusted)
        }
    }
}

// MARK: - extension
extension PINGLECTAButton {
    func activateButton() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.isEnabled = true
    }
    
    func disabledButton() {
        self.backgroundColor = .grayscaleG08
        self.setTitleColor(.grayscaleG10, for: .normal)
        self.isEnabled = false
    }
}

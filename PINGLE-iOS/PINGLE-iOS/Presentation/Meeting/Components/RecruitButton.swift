//
//  RecruitButton.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/8/24.
//

import UIKit

import SnapKit

class RecruitButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(title: String, buttonColor: UIColor, textColor: UIColor, touchEnable: Bool) {
        super.init(frame: .zero)
        commonInit()
        setLayout()
        self.backgroundColor = buttonColor
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.isEnabled = touchEnable
    }
    
// MARK: - Function
    private func commonInit() {
        self.titleLabel?.font = .titleTitleSemi24
        self.layer.cornerRadius = 10.adjusted
    }

// MARK: - UI
    private func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(50.adjusted)
            $0.height.equalTo(51.adjusted)
        }
    }
}

// MARK: - extension
extension RecruitButton {
    func activateButton() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.isEnabled = true
    }
    
    func disabledButton() {
        self.backgroundColor = .grayscaleG08
        self.setTitleColor(.grayscaleG09, for: .normal)
        self.isEnabled = false
    }
}

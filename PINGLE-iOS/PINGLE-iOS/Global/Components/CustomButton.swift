//
//  CustomButton.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//

import UIKit

import SnapKit

class MyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(title: String, color: UIColor, fontColor: UIColor) {
        super.init(frame: .zero)
        commonInit()
        setLayout()
        setTitle(title, for: .normal)
        setTitleColor(fontColor, for: .normal)
        backgroundColor = color
        layer.cornerRadius = 10
    }
    
    private func commonInit() {
        titleLabel?.font = .subtitleSubSemi16
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

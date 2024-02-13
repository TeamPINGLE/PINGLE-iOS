//
//  SettingSelectButton.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/6/24.
//

import UIKit

import SnapKit
import Then

class SettingSelectButton: UIButton {
    
    // MARK: Property
    private let settingTitleLabel = UILabel()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(settingTitle: String) {
        super.init(frame: CGRect())
        self.settingTitleLabel.text = settingTitle
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        settingTitleLabel.do {
            $0.font = .bodyBodyMed16
            $0.textColor = .white
        }
    }
    
    func setLayout() {
        addSubviews(settingTitleLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.adjusted)
            $0.height.equalTo(50)
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
        }
    }
}

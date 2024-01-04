//
//  MeetingExitButton.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/4/24.
//

import UIKit

import SnapKit

class MeetingExitButton: UIButton {
    // MARK: Property
    let underlineView = UIView()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UI
    private func setStyle() {
        self.backgroundColor = UIColor.clear
        self.setTitle(StringLiterals.Metting.MettingCategory.ExitButton.exitButton, for: .normal)
        self.setTitleColor(.grayscaleG06, for: .normal)
        self.titleLabel?.font = .captionCapSemi12
        self.underlineView.backgroundColor = .grayscaleG06
    }
    
    private func setLayout() {
        self.addSubview(underlineView)
        
        self.snp.makeConstraints {
            $0.width.equalTo(32.adjustedWidth)
            $0.height.equalTo(17.adjustedHeight)
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(1.adjusted)
            $0.height.equalTo(1.adjusted)
        }
    }
}

//
//  PINGLEWarningToastView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/5/24.
//

import UIKit

import SnapKit
import Then

final class PINGLEWarningToastView: BaseView {
    
    // MARK: Property
    let warningLabel = UILabel()
    let warningImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(warningLabel: String) {
        super.init(frame: .zero)
        self.warningLabel.text = warningLabel
    }
    
    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .systemRedAlert
            $0.layer.cornerRadius = 5.adjusted
        }
        
        warningImageView.do {
            $0.image = UIImage(resource: .icNotice)
        }
        
        warningLabel.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        addSubviews(warningImageView, warningLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(343.adjusted)
            $0.height.equalTo(50)
        }
        
        warningImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(17.adjusted)
            $0.height.width.equalTo(24)
        }
        
        warningLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(warningImageView.snp.trailing).offset(8.adjusted)
        }
    }
    
    func changeWarningMessage(message: String, possible: Bool) {
        if possible {
            self.backgroundColor = .white
            warningImageView.image = UIImage(resource: .icCheckGray)
            warningLabel.textColor = .black
        } else {
            self.backgroundColor = .systemRedAlert
            warningImageView.image = UIImage(resource: .icNotice)
            warningLabel.textColor = .white
        }
        
        warningLabel.text = message
    }
}

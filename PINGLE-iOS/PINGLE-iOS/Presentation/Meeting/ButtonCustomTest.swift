//
//  ButtonCustomTest.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//
import UIKit

import Then
import SnapKit

class ButtonCustomTest: BaseViewController {
// MARK: Property
    let finalView = FinalSummaryView()

// MARK: - UI
    override func setStyle() {
        view.backgroundColor = .white
    }
    
    override func setLayout() {
        view.addSubview(finalView)

        finalView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

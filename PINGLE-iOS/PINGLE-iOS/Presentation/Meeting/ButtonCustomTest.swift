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

    let topButton = MyButton(title: "핑글 개최하러 가기", color: .white, fontColor: .black)
    let bottomButton = MyButton(title: "다음으로", color: .grayscaleG08, fontColor: .grayscaleG10)
    
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
    }
    
    override func setLayout() {
        view.addSubviews(topButton, bottomButton)
        
        topButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(50)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        bottomButton.snp.makeConstraints {
            $0.top.equalTo(topButton.snp.bottom).offset(50)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
    }
}

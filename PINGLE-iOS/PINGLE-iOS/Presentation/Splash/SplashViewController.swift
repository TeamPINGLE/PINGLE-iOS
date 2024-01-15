//
//  SplashViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class SplashViewController: BaseViewController {
    
    // MARK: Component
    private let PINGLELogoImageView = UIImageView()
    
    override func setStyle() {
        PINGLELogoImageView.do {
            $0.image = ImageLiterals.OnBoarding.imgPINGLELogo
        }
    }
    
    override func setLayout() {
        view.addSubview(PINGLELogoImageView)
        
        PINGLELogoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(153)
            $0.height.equalTo(191)
        }
    }
}

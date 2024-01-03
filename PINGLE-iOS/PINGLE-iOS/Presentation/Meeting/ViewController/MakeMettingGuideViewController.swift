//
//  MakeMettingGuideViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class MakeMettingGuideViewController: BaseViewController {
    
    // MARK: Property
    private let mettingImageView = UIImageView()
    private let exitButton = UIButton()
    private let guideTitle = UILabel()
    private let guideSubTitle = UILabel()
    private let entranceButton = UIButton()
    
    // MARK: UI
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
        
        self.mettingImageView.do {
            $0.image = ImageLiterals.Metting.Guide.imgMettingGraphic
            $0.contentMode = .scaleAspectFit
        }
        
        self.exitButton.do {
            $0.setImage(ImageLiterals.Metting.Guide.imgExitButton, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        self.guideTitle.do {
            $0.text = StringLiterals.Metting.MettingGuide.guideTitle
            $0.font = .titleTitleSemi32
            $0.textColor = .white
            $0.numberOfLines = 2
        }
        
        self.guideSubTitle.do {
            $0.text = StringLiterals.Metting.MettingGuide.guideSubTitle
            $0.font = .subtitleSubSemi16
            $0.textColor = .white
            $0.numberOfLines = 2
        }
        
    }
    
    override func setLayout() {
        view.addSubviews(exitButton, mettingImageView, guideTitle, guideSubTitle, entranceButton)
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16.adjusted)
            $0.leading.equalToSuperview().offset(333.adjusted)
        }
        
        mettingImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(133.adjusted)
        }
        
        guideTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(88.adjusted)
            $0.leading.equalToSuperview().offset(24.adjusted)
        }
        
        guideSubTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(194.adjusted)
            $0.leading.equalToSuperview().offset(24.adjusted)
        }
        
    }
}

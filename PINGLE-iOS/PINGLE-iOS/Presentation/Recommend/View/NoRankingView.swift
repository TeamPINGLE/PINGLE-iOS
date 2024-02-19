//
//  NoRankingView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/20/24.
//

import UIKit

import SnapKit
import Then

final class NoRankingView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    
    let rankingTitleLabel = UILabel()
    
    // MARK: - Function
    // MARK: Style Helpers
    
    override func setStyle() {
        self.backgroundColor = .grayscaleG11
        
        rankingTitleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Recommend.nonRanking, lineHeight: 25)
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
            $0.textAlignment = .center
            $0.numberOfLines = 2 
        }
    }
    
    // MARK: Layout Helpers
    
    override func setLayout() {
        self.addSubview(rankingTitleLabel)
        
        rankingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(201.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
    }
}

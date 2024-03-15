//
//  RankingNumberView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/20/24.
//

import UIKit

import SnapKit
import Then

final class RankingNumberView: BaseView {
    
    // MARK: - Variables
    // MARK: Component
    let rankingIcon = UIImageView()
  
    // MARK: - Function
    // MARK: Style Helpers
    override func setStyle() {
        self.backgroundColor = .black
        
        self.do {
            $0.makeCornerRound(radius: 9.5)
        }

        rankingIcon.do {
            $0.image = UIImage(resource: .icRankingPin)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        self.addSubviews(rankingIcon)
        
        self.snp.makeConstraints {
            $0.height.equalTo(19)
        }
        
        rankingIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(6.adjusted)
        }
    }
}

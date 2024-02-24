//
//  RankingView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/20/24.
//

import UIKit

import SnapKit
import Then

final class RankingView: BaseView {

    // MARK: - Property
    let rankingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: - UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        rankingCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: 32,
                                           right: 0)
        }
    }
    
    override func setLayout() {
        self.addSubviews(rankingCollectionView)

        rankingCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(17.adjusted)
        }
    }
}

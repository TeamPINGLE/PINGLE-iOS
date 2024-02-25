//
//  KeywordColletionViewCell.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/25/24.
//

import UIKit

import SnapKit
import Then

final class KeywordColletionViewCell: UICollectionViewCell {
    
    static let identifier = "KeywordColletionViewCell"
    
    // MARK: Property
    private let keywordTitleLabel = UILabel()
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG09
            $0.makeCornerRound(radius: 19)
        }
        
        keywordTitleLabel.do {
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG02
            $0.textAlignment = .center
        }
    }
    
    func setLayout() {
        self.addSubviews(keywordTitleLabel)
        
        keywordTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bindData(data: keywordSample) {
        keywordTitleLabel.text = data.value
    }
}

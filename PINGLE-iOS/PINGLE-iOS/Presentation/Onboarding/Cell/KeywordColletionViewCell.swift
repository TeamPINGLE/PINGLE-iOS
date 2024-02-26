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
    
    func bindData(data: KeywordResponseDTO) {
        keywordTitleLabel.text = data.value
    }
    
    /// cell이 선택되었을 때 색상이 변한다.
    func changeCellColor(selected: Bool) {
        if selected {
            keywordTitleLabel.textColor = .black
            self.backgroundColor = .mainPingleGreen
        } else {
            keywordTitleLabel.textColor = .grayscaleG02
            self.backgroundColor = .grayscaleG09
        }
    }
}

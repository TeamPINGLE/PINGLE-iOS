//
//  ChipCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/2/24.
//

import UIKit

import SnapKit

enum ChipStatus {
    case play
    case study
    case multi
    case others
}

final class ChipCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ChipCollectionViewCell"
    
    let chipButton = UIButton()
    var isButtonSelected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        chipButton.do {
            $0.setImage(ImageLiterals.Home.Chips.btnPlayChip, for: .normal)
            $0.makeShadow(radius: 4.12, offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
    }
    
    private func setLayout() {
        self.addSubviews(chipButton)
        
        chipButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setButtonState(state: ChipStatus) {
        switch state {
        case .play:
            chipButton.setImage(ImageLiterals.Home.Chips.btnPlayChip, for: .normal)
            
        case .study:
            chipButton.setImage(ImageLiterals.Home.Chips.btnStudyChip, for: .normal)

        case .multi:
            chipButton.setImage(ImageLiterals.Home.Chips.btnMultiChip, for: .normal)

        case .others:
            chipButton.setImage(ImageLiterals.Home.Chips.btnOtherChip, for: .normal)
        }
    }
}

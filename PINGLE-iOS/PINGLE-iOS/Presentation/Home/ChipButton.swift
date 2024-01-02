//
//  ChipButton.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/3/24.
//

import UIKit

import SnapKit
import Then

enum ChipStatus {
    case play
    case study
    case multi
    case others
}

class ChipButton: UIButton {
    
    var chipStatus: ChipStatus = .play
    var isButtonSelected: Bool = false {
        didSet {
            setButtonStatus(state: chipStatus)
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Custom Init
    init(state: ChipStatus) {
        super.init(frame: CGRect())
        self.setButtonStatus(state: state)
        setUI()
    }
}

// MARK: - extension
extension ChipButton {
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
        setButtonStatus(state: chipStatus)
    }
    
    private func setStyle() {
        self.do {
            $0.setImage(ImageLiterals.Home.Chips.btnPlayChip, for: .normal)
            $0.makeShadow(radius: 4.12, offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
    }
    
    private func setLayout() { }
    
    func setButtonStatus(state: ChipStatus) {
        self.chipStatus = state

        if isButtonSelected {
            setButtonSelected(state: state)
        } else {
            setButtonUnselected(state: state)
        }
    }
    
    func setButtonUnselected(state: ChipStatus) {
        switch state {
        case .play:
            self.setImage(ImageLiterals.Home.Chips.btnPlayChip, for: .normal)
            
        case .study:
            self.setImage(ImageLiterals.Home.Chips.btnStudyChip, for: .normal)

        case .multi:
            self.setImage(ImageLiterals.Home.Chips.btnMultiChip, for: .normal)

        case .others:
            self.setImage(ImageLiterals.Home.Chips.btnOtherChip, for: .normal)
        }
    }
    
    func setButtonSelected(state: ChipStatus) {
        switch state {
        case .play:
            self.setImage(ImageLiterals.Home.Chips.btnPlayChipSelected, for: .normal)
            
        case .study:
            self.setImage(ImageLiterals.Home.Chips.btnStudyChipSelected, for: .normal)

        case .multi:
            self.setImage(ImageLiterals.Home.Chips.btnMultiChipSelected, for: .normal)

        case .others:
            self.setImage(ImageLiterals.Home.Chips.btnOthersChipSelected, for: .normal)
        }
    }
}

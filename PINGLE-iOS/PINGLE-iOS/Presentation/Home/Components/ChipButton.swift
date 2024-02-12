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
    
    // MARK: - Variables
    // MARK: Property
    var chipStatus: ChipStatus = .play
    var chipStatusString: String = "PLAY"
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
            $0.setImage(UIImage(resource: .btnPlayChip), for: .normal)
            $0.makeShadow(radius: 4.12, offset: CGSize(width: 0, height: 0), opacity: 0.25)
        }
    }
    
    private func setLayout() { }
    
    func setButtonStatus(state: ChipStatus) {
        self.chipStatus = state
        
        switch state {
        case .play:
            self.chipStatusString = "PLAY"
        case .study:
            self.chipStatusString = "STUDY"
        case .multi:
            self.chipStatusString = "MULTI"
        case .others:
            self.chipStatusString = "OTHERS"
        }
        
        if isButtonSelected {
            setButtonSelected(state: state)
        } else {
            setButtonUnselected(state: state)
        }
    }
    
    func setButtonUnselected(state: ChipStatus) {
        switch state {
        case .play:
            self.setImage(UIImage(resource: .btnPlayChip), for: .normal)
            
        case .study:
            self.setImage(UIImage(resource: .btnStudyChip), for: .normal)
            
        case .multi:
            self.setImage(UIImage(resource: .btnMultiChip), for: .normal)
            
        case .others:
            self.setImage(UIImage(resource: .btnOtherChip), for: .normal)
        }
    }
    
    func setButtonSelected(state: ChipStatus) {
        switch state {
        case .play:
            self.setImage(UIImage(resource: .btnPlayChipSelected), for: .normal)
            
        case .study:
            self.setImage(UIImage(resource: .btnStudyChipSelected), for: .normal)
            
        case .multi:
            self.setImage(UIImage(resource: .btnMultiChipSelected), for: .normal)
            
        case .others:
            self.setImage(UIImage(resource: .btnOthersChipSelected), for: .normal)
        }
    }
}

//
//  MyPINGLESegmentControl.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class MyPINGLESegmentControl: UISegmentedControl {
    
    // MARK: - Variables
    // MARK: Component
    private lazy var selectedUnderlineView = UIView()
    
    // MARK: - Function
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        removeBackgroundAndDivider()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        removeBackgroundAndDivider()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Layout Helpers
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
}

// MARK: - extension
extension MyPINGLESegmentControl {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        selectedUnderlineView.do {
            $0.backgroundColor = .white
            $0.makeCornerRound(radius: 1)
        }
    }
    
    private func setLayout() {
        self.addSubviews(
            selectedUnderlineView
        )
        
        let segmentWidth = self.bounds.width / CGFloat(self.numberOfSegments)
        let underlineFinalXPosition = segmentWidth * CGFloat(self.selectedSegmentIndex)
        selectedUnderlineView.frame = CGRect(x: underlineFinalXPosition + 25.5.adjustedWidth, y: self.bounds.size.height - 2.0, width: 117.adjustedWidth, height: 2.0)
        
        self.layer.cornerRadius = 0
    }
    
    // MARK: Custom Function
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}

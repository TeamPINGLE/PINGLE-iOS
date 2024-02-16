//
//  HomeListCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 2/17/24.
//

import UIKit

import SnapKit
import Then

final class HomeListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "HomeListCollectionViewCell"
    
    let homeMapDetailView = HomeMapDetailView()
    let toggleBackgroundView = UIView()
    let toggleButton = UIButton()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
//        setDimmedView()
//        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        homeMapDetailView.do {
            $0.topBackgroundView.backgroundColor = .grayscaleG10
            $0.bottomBackgroundView.backgroundColor = .grayscaleG10
            $0.bottomBackgroundView.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
            $0.participantCountButton.backgroundColor = .grayscaleG09
        }
        
        toggleBackgroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        }
        
        toggleButton.do {
            $0.setImage(UIImage(resource: .icListArrowDown), for: .normal)
        }
        
    }
    
    private func setLayout() {
        self.addSubviews(homeMapDetailView,
                         toggleBackgroundView)
        
        toggleBackgroundView.addSubviews(toggleButton)
        
        homeMapDetailView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        toggleBackgroundView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalToSuperview()
            $0.top.equalTo(homeMapDetailView.snp.bottom)
        }
        
        toggleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

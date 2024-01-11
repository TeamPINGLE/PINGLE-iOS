//
//  HomeDetailCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class HomeDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "HomeDetailCollectionViewCell"
    
    let mapDetailView = HomeMapDetailView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() { }
    
    private func setLayout() {
        self.addSubviews(mapDetailView)
        
        mapDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

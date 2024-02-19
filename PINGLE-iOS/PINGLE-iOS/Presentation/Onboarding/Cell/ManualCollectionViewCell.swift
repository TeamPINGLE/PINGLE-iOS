//
//  ManualCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/13/24.
//

import UIKit

import SnapKit
import Then

final class ManualCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ManualCollectionViewCell"
    
    // MARK: Property
    private let manualImageView = UIImageView()
    
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
            $0.backgroundColor = .grayscaleG11
        }
        
        manualImageView.image = UIImage(resource: .imgManual1)
    }
    
    func setLayout() {
        self.addSubviews(manualImageView)
        
        manualImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(440)
        }
    }
    
    func bindImage(image: UIImage) {
        manualImageView.image = UIImage(resource: .imgManual1)
    }
}

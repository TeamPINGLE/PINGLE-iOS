//
//  SearchCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "SearchCollectionViewCell"
    
    // MARK: Properties
    private let keywordLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8))
    private let groupNameLabel = UILabel()
    private let selectImageView = UIImageView()
    private let horizontalLineView = UIView()
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectImageView.image = ImageLiterals.Icon.imgCheckDefault
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.keywordLabel.do {
            $0.font = .captionCapSemi10
            $0.textColor = .mainPingleGreen
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
            $0.layer.cornerRadius = 10.adjusted
        }
        
        self.groupNameLabel.do {
            $0.font = .bodyBodyMed16
            $0.textColor = .white
        }
        
        self.selectImageView.do {
            $0.image = ImageLiterals.Icon.imgCheckDefault
        }
        
        self.horizontalLineView.do {
            $0.backgroundColor = .grayscaleG09
        }
    }
    
    func setLayout() {
        self.addSubviews(keywordLabel, groupNameLabel, selectImageView, horizontalLineView)
        
        self.keywordLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        self.groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(keywordLabel.snp.trailing).offset(8.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        self.selectImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24.adjusted)
        }
        
        self.horizontalLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1.adjusted)
        }
    }
    
    // MARK: Custom Function
    func changeSelectedImage() {
        selectImageView.image = ImageLiterals.Icon.imgCheckSelected
    }
    
    func bindData(data: SearchOrganizationResponseDTO) {
        keywordLabel.text = data.keyword
        groupNameLabel.text = data.name
    }
}

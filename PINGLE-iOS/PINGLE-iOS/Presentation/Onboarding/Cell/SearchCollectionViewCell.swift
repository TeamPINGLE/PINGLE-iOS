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
        selectImageView.image = UIImage(resource: .imgCheckDefault)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        keywordLabel.do {
            $0.font = .captionCapSemi10
            $0.textColor = .mainPingleGreen
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
            $0.makeCornerRound(radius: 10)
        }
        
        groupNameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 22)
            $0.font = .bodyBodyMed16
            $0.textColor = .white
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
        
        selectImageView.do {
            $0.image = UIImage(resource: .imgCheckDefault)
        }
        
        horizontalLineView.do {
            $0.backgroundColor = .grayscaleG09
        }
    }
    
    func setLayout() {
        addSubviews(keywordLabel, 
                    groupNameLabel,
                    selectImageView,
                    horizontalLineView)
        
        keywordLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.leading.equalTo(keywordLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(55)
            $0.centerY.equalToSuperview()
        }
        
        selectImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: Custom Function
    func changeSelectedImage() {
        selectImageView.image = UIImage(resource: .imgCheckSelected)
    }
    
    func bindData(data: SearchOrganizationResponseDTO) {
        keywordLabel.text = data.keyword
        groupNameLabel.text = data.name
    }
}

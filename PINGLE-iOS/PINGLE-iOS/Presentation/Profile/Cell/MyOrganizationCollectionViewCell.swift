//
//  MyOrganizationCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class MyOrganizationCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MyOrganizationCollectionViewCell"
    
    // MARK: Properties
    private let keywordLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    private let organizationNameLabel = UILabel()
    private let ownerImageView = UIImageView()
    
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
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 12)
        }
        
        keywordLabel.do {
            $0.font = .captionCapSemi12
            $0.textColor = .mainPingleGreen
            $0.layer.backgroundColor = UIColor.grayscaleG07.cgColor
            $0.makeCornerRound(radius: 12.5)
        }
        
        organizationNameLabel.do {
            $0.setTextWithLineHeight(text: " ", lineHeight: 28)
            $0.font = .titleTitleSemi20
            $0.textColor = .grayscaleG01
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byTruncatingTail
        }
        
        ownerImageView.do {
            $0.image = UIImage(resource: .imgDefaltOwner)
            $0.isHidden = true
        }
    }
    
    func setLayout() {
        self.addSubviews(keywordLabel,
                         organizationNameLabel,
                         ownerImageView)
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(24)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        ownerImageView.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.size.equalTo(57)
        }
    }
    
    // MARK: Bind Function
    func bindData(data: MyTeamsResponseDTO) {
        keywordLabel.text = data.keyword
        organizationNameLabel.text = data.name
        
        if data.isOwner {
            ownerImageView.isHidden = false
        } else {
            ownerImageView.isHidden = true
        }
    }
}

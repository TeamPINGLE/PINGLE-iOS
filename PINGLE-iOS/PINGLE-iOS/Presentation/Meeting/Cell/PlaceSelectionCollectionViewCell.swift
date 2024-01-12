//
//  PlaceSelectionCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/7/24.
//

import UIKit

import SnapKit
import Then

final class PlaceSelectionCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "placeSelectionCollectionViewCell"
    
    // MARK: Properties
    private let placeName = UILabel()
    private let placeDetailedAddress = UILabel()
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
        
        self.placeName.do {
            $0.text = "장소 이름"
            $0.font = .subtitleSubSemi16
            $0.textColor = .white
        }
        
        self.placeDetailedAddress.do {
            $0.text = "상세 주소"
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG06
        }
        
        self.selectImageView.do {
            $0.image = ImageLiterals.Icon.imgCheckDefault
        }
        
        self.horizontalLineView.do {
            $0.backgroundColor = .grayscaleG09
        }
    }
    
    func setLayout() {
        self.addSubviews(placeName, placeDetailedAddress, selectImageView, horizontalLineView)
        
        self.placeName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview()
        }
        
        self.placeDetailedAddress.snp.makeConstraints {
            $0.top.equalToSuperview().inset(59)
            $0.leading.equalToSuperview()
        }
        
        self.selectImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(11.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24)
        }
        
        self.horizontalLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: Custom Function
    func changeSelectedImage() {
        selectImageView.image = ImageLiterals.Icon.imgCheckSelected
    }
    
    func bindData(data: SearchPlaceResponseDTO) {
        placeName.text = data.location
        placeDetailedAddress.text = data.address
    }
}

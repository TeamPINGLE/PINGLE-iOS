//
//  SearchOrganizationView.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class SearchOrganizationView: BaseView {

    // MARK: Property
    private let searchView = UIView()
    let searchTextField = UITextField()
    private let searchImageView = UIImageView()
    let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .black
        }
        
        self.searchView.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 8.adjusted
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
        
        self.searchTextField.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .white
            $0.returnKeyType = .search
            $0.enablesReturnKeyAutomatically = true
            $0.attributedPlaceholder = NSAttributedString(
                string: StringLiterals.Onboarding.SearchBarPlaceholder.searchOrganizationPlaceholder,
                attributes: [
                    .font: UIFont.bodyBodyMed14,
                    .foregroundColor: UIColor.grayscaleG07
                ]
            )
        }
        
        self.searchImageView.do {
            $0.image = ImageLiterals.Icon.imgSearchIcon
        }
        
        self.searchCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func setLayout() {
        self.addSubviews(searchView, searchCollectionView)
        self.searchView.addSubviews(searchTextField, searchImageView, searchImageView)
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(44.adjusted)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10.adjusted)
            $0.leading.equalToSuperview().inset(13.adjusted)
            $0.trailing.equalToSuperview().inset(54.adjusted)
        }
        
        searchImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24.adjusted)
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.searchView.snp.bottom).offset(21.adjusted)
            $0.leading.trailing.equalToSuperview().inset(25.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
}

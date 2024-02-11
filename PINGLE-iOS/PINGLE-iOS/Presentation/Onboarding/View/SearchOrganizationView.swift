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
    let searchButton = UIButton()
    let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let noResultLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.searchView.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 8.adjusted
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
        
        self.searchTextField.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .white
            $0.tintColor = .mainPingleGreen
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
        
        self.searchButton.do {
            $0.setImage(UIImage(resource: .icsvgSearch), for: .normal)
        }
        
        self.searchCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        self.noResultLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.noResult
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        self.addSubviews(searchView, noResultLabel, searchCollectionView)
        self.searchView.addSubviews(searchTextField, searchButton)
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(44)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(13.adjusted)
            $0.trailing.equalToSuperview().inset(54.adjusted)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24)
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.searchView.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview().inset(25.adjusted)
            $0.bottom.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(searchCollectionView)
        }
    }
    
    // MARK: Custom Function
    func isHiddenResultLabel(isEnabled: Bool) {
        noResultLabel.isHidden = isEnabled
    }
}

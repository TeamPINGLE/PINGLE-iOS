//
//  SearchPlaceView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/8/24.
//

import UIKit

import SnapKit
import Then

final class SearchPlaceView: BaseView {

    // MARK: - Property
    private let searchPlaceView = UIView()
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let clearButton = UIButton()
    let searchPlaceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let noPlaceResult = UILabel()
    let reSearch = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: - UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        searchPlaceView.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 8.adjusted
        }
        
        searchTextField.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .white
            $0.tintColor = .mainPingleGreen
            $0.returnKeyType = .search
            $0.enablesReturnKeyAutomatically = true
            $0.attributedPlaceholder = NSAttributedString(
                string: StringLiterals.Meeting.SearhPlace.placeholder,
                attributes: [
                    .font: UIFont.bodyBodyMed14,
                    .foregroundColor: UIColor.grayscaleG07
                ]
            )
        }
        
        searchButton.do {
            $0.setImage(UIImage(resource: .icSearch), for: .normal)
        }
        
        clearButton.do {
            $0.setImage(UIImage(resource: .btnClear), for: .normal)
            $0.isHidden = true
        }
        
        searchPlaceCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        
        noPlaceResult.do {
            $0.text = StringLiterals.Meeting.SearhPlace.noPlaceResult
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
        }
        
        reSearch.do {
            $0.text = StringLiterals.Meeting.SearhPlace.reSearch
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG08
        }
    }
    
    override func setLayout() {
        self.addSubviews(searchPlaceView, noPlaceResult, reSearch, searchPlaceCollectionView)
        searchPlaceView.addSubviews(searchTextField, searchButton, clearButton)
        
        searchPlaceView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(44.adjusted)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.adjusted)
            $0.leading.equalToSuperview().inset(13.adjusted)
            $0.trailing.equalToSuperview().inset(54.adjusted)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24.adjusted)
        }
        
        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24.adjusted)
        }
        
        searchPlaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.searchPlaceView.snp.bottom).offset(21.adjusted)
            $0.leading.trailing.equalToSuperview().inset(25.adjusted)
            $0.bottom.equalToSuperview()
        }
        
        noPlaceResult.snp.makeConstraints {
            $0.centerX.equalTo(searchPlaceCollectionView)
            $0.top.equalTo(searchPlaceView.snp.bottom).offset(92.adjusted)
        }
        
        reSearch.snp.makeConstraints {
            $0.centerX.equalTo(searchPlaceCollectionView)
            $0.top.equalTo(noPlaceResult.snp.bottom).offset(4.adjusted)
        }
    }
    
    // MARK: - Function
    func isHiddenResultLabel(isEnabled: Bool) {
        noPlaceResult.isHidden = isEnabled
        reSearch.isHidden = isEnabled
    }
}

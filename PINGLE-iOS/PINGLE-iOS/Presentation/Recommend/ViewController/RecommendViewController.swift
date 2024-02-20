//
//  RecommendViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class RecommendViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let titleLabel = UILabel()
    private let noRakingView = NoRankingView()
    private let rankingView = RankingView()
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        self.view.backgroundColor = .grayscaleG11
        
        titleLabel.do {
            $0.text = StringLiterals.Recommend.rankingTitle
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        
        self.view.addSubviews(titleLabel, 
                              /*noRakingView,*/
                              rankingView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(59.adjustedHeight)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        rankingView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight)
        }
        
//        noRakingView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaInsets).offset(100.adjustedHeight)
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(safeAreaHeight)
//        }
    }
    
    // MARK: - Func
    // MARK: Delegate
    override func setDelegate() {
        self.rankingView.rankingCollectionView.delegate = self
        self.rankingView.rankingCollectionView.dataSource = self
    }
    
    // MARK: Register
    func setRegister() {
        self.rankingView.rankingCollectionView.register(RankingCollectionViewCell.self,
                                                                  forCellWithReuseIdentifier: RankingCollectionViewCell.identifier)
    }
}

// MARK: - extension
// MARK: UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCollectionViewCell.identifier,
                                                            for: indexPath) as? RankingCollectionViewCell else {return UICollectionViewCell()}
        cell.bindData(data: rankingCollectionList[indexPath.row], ranking: indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rankingView.rankingCollectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelHeight = calculateDynamicHeight(placeNameText: rankingCollectionList[indexPath.row].name)
        return CGSize(width: 341.adjusted, height: labelHeight + 96)
    }
    
    func calculateDynamicHeight(placeNameText: String) -> CGFloat {
        let placeName = UILabel()
        placeName.text = placeNameText
        placeName.numberOfLines = 2
        placeName.preferredMaxLayoutWidth = 270.adjusted
        placeName.font = .bodyBodySemi14

        let placeNameSize = placeName.sizeThatFits(CGSize(width: 270.adjusted, height: CGFloat.greatestFiniteMagnitude))

        return placeNameSize.height
    }
}

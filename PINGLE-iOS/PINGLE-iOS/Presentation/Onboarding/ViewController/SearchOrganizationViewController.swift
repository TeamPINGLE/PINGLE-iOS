//
//  SearchOrganizationViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/3/24.
//

import UIKit

import SafariServices
import SnapKit
import Then

final class SearchOrganizationViewController: BaseViewController {
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let searchOrganizationView = SearchOrganizationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        setRegister()
    }
    
    // MARK: UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .black
        }
        
        self.backButton.do {
            $0.setImage(ImageLiterals.Icon.imgArrowLeft, for: .normal)
        }
        
        self.titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.searchOrganization
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.numberOfLines = 0
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleLabel, searchOrganizationView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32.adjusted)
            $0.leading.equalTo(self.view.snp.leading).offset(26.adjusted)
        }
        
        searchOrganizationView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(314.adjusted)
        }
    }
    
    // MARK: Delegate
    override func setDelegate() {
        self.searchOrganizationView.searchCollectionView.delegate = self
        self.searchOrganizationView.searchCollectionView.dataSource = self
    }
    
    // MARK: Register
    func setRegister() {
        self.searchOrganizationView.searchCollectionView.register(SearchCollectionViewCell.self,
                                                                  forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.title = StringLiterals.Onboarding.NavigationTitle.searchOrganizationNavigation
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.subtitleSubSemi18
        ]
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - extension
// MARK: UICollectionViewDelegate
extension SearchOrganizationViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension SearchOrganizationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier,
                                                            for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        return item
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SearchOrganizationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325.adjusted , height: 88.adjusted)
    }
}

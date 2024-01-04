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
    
    // MARK: - Variables
    var selectedCellIndex: IndexPath?
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let searchOrganizationView = SearchOrganizationView()
    private let bottomRequestLabel = UILabel()
    private let makeOrganizationButton = UIButton()
    private let bottomCTAButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        setRegister()
        hideKeyboardWhenTappedAround()
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
        
        self.bottomRequestLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.bottomRequest
            $0.font = .captionCapSemi12
            $0.textColor = .white
        }
        
        self.makeOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.requestOrganization, for: .normal)
            $0.titleLabel?.font = .captionCapSemi12
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder([.bottom], color: .white, width: 1.0, frameHeight: 17.0.adjusted, framgeWidth: 121.0.adjusted)
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(titleLabel, searchOrganizationView, bottomRequestLabel, makeOrganizationButton, bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32.adjusted)
            $0.leading.equalTo(self.view.snp.leading).offset(26.adjusted)
        }
        
        searchOrganizationView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(154.adjusted)
        }
        
        bottomRequestLabel.snp.makeConstraints {
            $0.top.equalTo(self.searchOrganizationView.snp.bottom).offset(18.adjusted)
            $0.leading.equalToSuperview().offset(77.adjusted)
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.centerY.equalTo(self.bottomRequestLabel.snp.centerY)
            $0.leading.equalTo(self.bottomRequestLabel.snp.trailing).offset(4.adjusted)
            $0.height.equalTo(17.adjusted)
            $0.width.equalTo(121.adjusted)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(41.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Delegate
    override func setDelegate() {
        self.searchOrganizationView.searchTextField.delegate = self
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
        searchOrganizationView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        searchOrganizationView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        makeOrganizationButton.addTarget(self, action: #selector(makeOrganizationButtonTapped), for: .touchUpInside)
        bottomCTAButton.addTarget(self, action: #selector(bottomCTAButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        self.view.endEditing(true)
    }
    
    @objc func makeOrganizationButtonTapped() {
        guard let url = URL(string: "https://www.google.com") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc func bottomCTAButtonTapped() {
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension SearchOrganizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("Text changed: \(textField.text ?? "")")
    }
}

// MARK: UICollectionViewDelegate
extension SearchOrganizationViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension SearchOrganizationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier,
                                                            for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        if indexPath == selectedCellIndex {
            cell.changeSelectedImage()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCellIndex == indexPath {
            selectedCellIndex = nil
            bottomCTAButton.disabledButton()
        } else {
            selectedCellIndex = indexPath
            bottomCTAButton.activateButton()
        }
        searchOrganizationView.searchCollectionView.reloadData()
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
        return CGSize(width: 325.adjustedWidth , height: 88.adjustedHeight)
    }
}

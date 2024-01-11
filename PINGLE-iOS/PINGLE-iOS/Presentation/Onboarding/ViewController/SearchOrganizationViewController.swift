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
    var searchOrganizationResponseDTO: [SearchOrganizationResponseDTO] = []
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let searchOrganizationView = SearchOrganizationView()
    private let bottomRequestLabel = UILabel()
    private let makeOrganizationButton = UIButton()
    private let bottomCTAButton = PINGLECTAButton(title: StringLiterals.CTAButton.buttonTitle, buttonColor: .grayscaleG08, textColor: .grayscaleG10)
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
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
            $0.backgroundColor = .grayscaleG11
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        searchOrganizationView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(154.adjusted)
        }
        
        bottomRequestLabel.snp.makeConstraints {
            $0.top.equalTo(self.searchOrganizationView.snp.bottom).offset(18.adjusted)
            $0.leading.equalToSuperview().inset(77.adjusted)
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.centerY.equalTo(self.bottomRequestLabel)
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
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
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
        searchOrganizationView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        makeOrganizationButton.addTarget(self, action: #selector(makeOrganizationButtonTapped), for: .touchUpInside)
        bottomCTAButton.addTarget(self, action: #selector(bottomCTAButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        /// 검색 결과가 없는 경우 "검색 결과가 없어요" 라벨이 나옵니다. 검색결과가 있는 경우 "검색 결과가 없어요" 라벨이 사라집니다.
        if let searchText = searchOrganizationView.searchTextField.text {
            if searchText.isEmpty {
                searchOrganizationResponseDTO = []
                searchOrganizationView.searchCollectionView.reloadData()
                searchOrganizationView.noResultLabel.isHidden = false
            } else {
                searchOrganization(data: SearchOrganizationRequestQueryDTO(name: searchText))
            }
        }
        /// 선택된 행 해제한 뒤, 다음으로 버튼 비활성화
        selectedCellIndex = nil
        bottomCTAButton.disabledButton()
        self.view.endEditing(true)
    }
    
    @objc func makeOrganizationButtonTapped() {
        guard let url = URL(string: "https://docs.google.com/forms/d/10WxvEzSVRrRvRGXsYf9Z5oXv4HsNuAwG2QicB4bY0aY/edit") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc func bottomCTAButtonTapped() {
        guard let selectedCellIndowRow = selectedCellIndex?.row else { return }
        let enterInviteCodeViewController = EnterInviteCodeViewController()
        enterInviteCodeViewController.teamId = searchOrganizationResponseDTO[selectedCellIndowRow].id
        navigationController?.pushViewController(enterInviteCodeViewController, animated: true)
    }
    
    // MARK: Network Function
    func searchOrganization(data: SearchOrganizationRequestQueryDTO) {
        NetworkService.shared.onboardingService.searchOrganization(queryDTO: data) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                /// 검색 결과가 없는 경우 "검색 결과가 없어요" 라벨이 나옵니다. 검색결과가 있는 경우 "검색 결과가 없어요" 라벨이 사라집니다.
                if data.isEmpty {
                    searchOrganizationView.noResultLabel.isHidden = false
                } else {
                    searchOrganizationView.noResultLabel.isHidden = true
                }
                self.searchOrganizationResponseDTO = data
                self.searchOrganizationView.searchCollectionView.reloadData()
            default:
                print("login error")
            }
        }
    }
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension SearchOrganizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        /// 검색 결과가 없는 경우 "검색 결과가 없어요" 라벨이 나옵니다. 검색결과가 있는 경우 "검색 결과가 없어요" 라벨이 사라집니다.
        if let searchText = textField.text {
            if searchText.isEmpty {
                searchOrganizationResponseDTO = []
                searchOrganizationView.searchCollectionView.reloadData()
                searchOrganizationView.noResultLabel.isHidden = false
            } else {
                searchOrganization(data: SearchOrganizationRequestQueryDTO(name: searchText))
            }
        }
        /// 선택된 행 해제한 뒤, 다음으로 버튼 비활성화
        selectedCellIndex = nil
        bottomCTAButton.disabledButton()
        return true
    }
}

// MARK: UICollectionViewDelegate
extension SearchOrganizationViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension SearchOrganizationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchOrganizationResponseDTO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier,
                                                            for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        cell.bindData(data: searchOrganizationResponseDTO[indexPath.row])
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
        return CGSize(width: UIScreen.main.bounds.size.width - 50.adjusted , height: 88)
    }
}

//
//  KeywordSelectionViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/24/24.
//

import UIKit

import SnapKit
import Then

final class KeywordSelectionViewController: BaseViewController {
    
    // MARK: Variables
    private var selectIndexPathRow: Int?
    private var keywordList: [KeywordResponseDTO]?
    var organizationName: String?
    var representativeEmail: String?
    
    // MARK: Property
    private let backButton = UIButton()
    private let infoButton = UIButton()
    private let titleLabel = UILabel()
    private let keywordColletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let bottomCTAButton = PINGLECTAButton(
        title: StringLiterals.CTAButton.buttonTitle,
        buttonColor: .grayscaleG08,
        textColor: .grayscaleG10
    )
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setRegister()
        setTarget()
        getKeyword()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        infoButton.do {
            $0.setImage(UIImage(resource: .icInfoBig), for: .normal)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.keyworkSelectTitle, lineHeight: 34)
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.textAlignment = .left
        }
        
        keywordColletionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.allowsMultipleSelection = false
            
            let layout = LeftAlignedCollectionViewFlowLayout()
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 12
            
            $0.collectionViewLayout = layout
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel,
                         keywordColletionView,
                         bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.leading.equalToSuperview().inset(26)
        }
        
        keywordColletionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(bottomCTAButton.snp.top).offset(-25)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setNavigation() {
        self.title = StringLiterals.Onboarding.NavigationTitle.makeOrganizationNavigation
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.subtitleSubSemi18
        ]
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
        
        let customInfoButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = customInfoButton
    }
    
    // MARK: Delegate
    override func setDelegate() {
        keywordColletionView.delegate = self
        keywordColletionView.dataSource = self
    }
    
    // MARK: Register
    func setRegister() {
        keywordColletionView.register(KeywordColletionViewCell.self,
                                      forCellWithReuseIdentifier: KeywordColletionViewCell.identifier)
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        infoButton.addTarget(self,
                             action: #selector(infoButtonTapped),
                             for: .touchUpInside)
        bottomCTAButton.addTarget(self,
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func infoButtonTapped() {
        presentMakeGroupGuideViewController()
    }
    
    @objc func bottomCTAButtonTapped() {
        guard let selectIndexPathRow = selectIndexPathRow else { return }
        let checkOrganizationViewController = CheckOrganizationViewController()
        
        checkOrganizationViewController.organizationName = organizationName
        checkOrganizationViewController.representativeEmail = representativeEmail
        checkOrganizationViewController.keyword = keywordList?[selectIndexPathRow]
        
        navigationController?.pushViewController(checkOrganizationViewController, animated: true)
    }
    
    // MARK: Present Function
    private func presentMakeGroupGuideViewController() {
        let makeOrganizationGuideViewController = MakeOrganizationGuideViewController()
        makeOrganizationGuideViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(makeOrganizationGuideViewController, animated: true)
    }
    
    // MARK: Network Function
    func getKeyword() {
        NetworkService.shared.onboardingService.keyword() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                keywordList = data
                keywordColletionView.reloadData()
            default:
                print("error")
            }
        }
    }
}


extension KeywordSelectionViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

// MARK: UICollectionViewDelegate
extension KeywordSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeywordColletionViewCell {
            if indexPath.row == selectIndexPathRow {
                cell.changeCellColor(selected: false)
                selectIndexPathRow = nil
                bottomCTAButton.disabledButton()
            } else {
                cell.changeCellColor(selected: true)
                selectIndexPathRow = indexPath.row
                bottomCTAButton.activateButton()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeywordColletionViewCell {
            cell.changeCellColor(selected: false)
        }
    }
}

// MARK: UICollectionViewDataSource
extension KeywordSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: KeywordColletionViewCell.identifier,
            for: indexPath
        ) as? KeywordColletionViewCell else { return UICollectionViewCell() }
        
        if let keyword = keywordList?[indexPath.row] {
            cell.bindData(data: keyword)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension KeywordSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (keywordList?[indexPath.row].value.width(withFont: .bodyBodyMed16) ?? 0) + 32
        
        return CGSize(width: cellWidth, height: 38)
    }
}

//
//  KeywordSelectionViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/24/24.
//

import UIKit

import SnapKit
import Then

struct keywordSample {
    let name: String
    let value: String
}

final class KeywordSelectionViewController: BaseViewController {
    
    let keyworkdList: [keywordSample] = [
        keywordSample(name: "CIRCLE", value: "연합동아리"),
        keywordSample(name: "CIRCLE", value: "교내동아리"),
        keywordSample(name: "CIRCLE", value: "학생회"),
        keywordSample(name: "CIRCLE", value: "대학교"),
        keywordSample(name: "CIRCLE", value: "고등학교"),
        keywordSample(name: "CIRCLE", value: "중학교"),
        keywordSample(name: "CIRCLE", value: "강의"),
        keywordSample(name: "CIRCLE", value: "스터디"),
        keywordSample(name: "CIRCLE", value: "사모임"),
        keywordSample(name: "CIRCLE", value: "동호회"),
        keywordSample(name: "CIRCLE", value: "기타"),
    ]
    
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
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func infoButtonTapped() {
        presentMakeGroupGuideViewController()
    }
    
    // MARK: Present Function
    private func presentMakeGroupGuideViewController() {
        let makeOrganizationGuideViewController = MakeOrganizationGuideViewController()
        makeOrganizationGuideViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(makeOrganizationGuideViewController, animated: true)
    }
}


extension KeywordSelectionViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

// MARK: UICollectionViewDelegate
extension KeywordSelectionViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension KeywordSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyworkdList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: KeywordColletionViewCell.identifier,
            for: indexPath
        ) as? KeywordColletionViewCell else { return UICollectionViewCell() }
        
        cell.bindData(data: keyworkdList[indexPath.row])
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension KeywordSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = keyworkdList[indexPath.row].value.width(withFont: .bodyBodyMed16) + 32
        
        return CGSize(width: cellWidth, height: 38)
    }
}

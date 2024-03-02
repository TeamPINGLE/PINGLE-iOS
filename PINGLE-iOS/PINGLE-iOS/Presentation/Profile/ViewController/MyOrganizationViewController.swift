//
//  MyOrganizationViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/14/24.
//

import UIKit

import SnapKit
import Then

final class MyOrganizationViewController: BaseViewController {
    
    // MARK: - Variables
    let myTeamsList: [MyTeamsResponseDTO] = [
        MyTeamsResponseDTO(id: 4, keyword: "연합동아리", name: "엄청나게길게", meetingCount: 5, participantCount: 7, isOwner: true, code: "helpME"),
        MyTeamsResponseDTO(id: 4, keyword: "연합동아리", name: "엄청나게길게쓴다고하면세상이달라질까", meetingCount: 5, participantCount: 7, isOwner: false, code: "helpME"),
        MyTeamsResponseDTO(id: 4, keyword: "연합동아리", name: "엄청나게길게쓴다고하면세상이달라질까", meetingCount: 5, participantCount: 7, isOwner: true, code: "helpME"),
        MyTeamsResponseDTO(id: 4, keyword: "연합동아리", name: "엄청나게길게쓴다고하면세상이달라질까 조약돌을 던져본다", meetingCount: 5, participantCount: 7, isOwner: false, code: "helpME"),
        MyTeamsResponseDTO(id: 4, keyword: "연합동아리", name: "엄청나게길게쓴다고하면세상이달라질까 세상은 그대로일거야", meetingCount: 5, participantCount: 7, isOwner: false, code: "helpME"),
        MyTeamsResponseDTO(id: 4, keyword: "연합동아리", name: "엄청나게길게쓴다고하면세상이달라질까그렇지만 조금씩 더 길게 써본다", meetingCount: 5, participantCount: 7, isOwner: true, code: "helpME")
    ]
    
    // MARK: Component
    private let backButton = UIButton()
    private let currentOrganizationView = CurrentOrganizationView()
    private let separationView = UIView()
    private let myOrganizationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let makeOrganizationButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setAddTarget()
        setRegister()
        currentOrganizationView.bindData(data: myTeamsList[0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigationBar(false)
    }
    
    // MARK: UI
    override func setStyle() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .grayscaleG11
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        separationView.do {
            $0.backgroundColor = .grayscaleG10
        }
        
        myOrganizationCollectionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        makeOrganizationButton.do {
            $0.setTitle(StringLiterals.Profile.ButtonTitle.makeOrganization, for: .normal)
            $0.titleLabel?.font = .captionCapSemi12
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder([.bottom], color: .white, width: 1.0, frameHeight: 17.0, framgeWidth: 124.0)
        }
    }
    
    override func setLayout() {
        view.addSubviews(currentOrganizationView, 
                         separationView,
                         myOrganizationCollectionView,
                         makeOrganizationButton)
        
        currentOrganizationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        separationView.snp.makeConstraints {
            $0.top.equalTo(currentOrganizationView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(7)
        }
        
        myOrganizationCollectionView.snp.makeConstraints {
            $0.top.equalTo(separationView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(makeOrganizationButton.snp.top).offset(-18)
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
            $0.width.equalTo(124)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar(_ appear: Bool) {
        if appear {
            navigationController?.navigationBar.isHidden = false
            tabBarController?.tabBar.isHidden = true
        } else {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    private func setNavigation() {
        self.title = StringLiterals.Onboarding.NavigationTitle.myOrganizationViewController
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.subtitleSubSemi18
        ]
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    // MARK: Delegate
    override func setDelegate() {
        myOrganizationCollectionView.delegate = self
        myOrganizationCollectionView.dataSource = self
    }
    
    // MARK: Register
    private func setRegister() {
        myOrganizationCollectionView.register(MyOrganizationCollectionViewCell.self,
                                      forCellWithReuseIdentifier: MyOrganizationCollectionViewCell.identifier)
    }
    
    // MARK: Target Function
    private func setAddTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: CalculateHeight Function
    private func calculateDynamicHeight(placeNameText: String) -> CGFloat {
        let organizationNameLabel = UILabel().then {
            $0.setTextWithLineHeight(text: placeNameText, lineHeight: 28)
            $0.font = .titleTitleSemi20
            $0.numberOfLines = 2
            $0.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 96
        }

        let organizationNameSize = organizationNameLabel.sizeThatFits(
            CGSize(width: UIScreen.main.bounds.width - 96,
                   height: CGFloat.greatestFiniteMagnitude)
        )

        return organizationNameSize.height
    }
}

// MARK: UICollectionViewDelegate
extension MyOrganizationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

// MARK: UICollectionViewDataSource
extension MyOrganizationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTeamsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyOrganizationCollectionViewCell.identifier,
            for: indexPath
        ) as? MyOrganizationCollectionViewCell else { return UICollectionViewCell() }
        
        cell.bindData(data: myTeamsList[indexPath.row])
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MyOrganizationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = 75 + calculateDynamicHeight(placeNameText: myTeamsList[indexPath.row].name)
        
        return CGSize(width: UIScreen.main.bounds.width - 48, height: cellHeight)
    }
}

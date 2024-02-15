//
//  HomeListViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/7/24.
//

import UIKit

import SnapKit
import Then

final class HomeListViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let sortButton = UIButton()
    private let sortTitleLabel = UILabel()
    private let sortImageView = UIImageView()
    private let sortMoreView = MoreView()
    let mapButton = UIButton()
    var listDummy: [HomePinDetailResponseDTO] = [HomePinDetailResponseDTO(id: 5, category: "PLAY", name: "생일파티", ownerName: "정채은", location: "가양역 9호선", date: "2024-05-23", startAt: "18:00:33", endAt: "23:00:33", maxParticipants: 20, curParticipants: 11, isParticipating: true, isOwner: false, chatLink: "naver.com"),
                                                 HomePinDetailResponseDTO(id: 5, category: "PLAY", name: "생일파티", ownerName: "정채은", location: "가양역 9호선", date: "2024-05-23", startAt: "18:00:33", endAt: "23:00:33", maxParticipants: 20, curParticipants: 11, isParticipating: true, isOwner: false, chatLink: "naver.com"),
                                                 HomePinDetailResponseDTO(id: 5, category: "PLAY", name: "생일파티", ownerName: "정채은", location: "가양역 9호선", date: "2024-05-23", startAt: "18:00:33", endAt: "23:00:33", maxParticipants: 20, curParticipants: 11, isParticipating: true, isOwner: false, chatLink: "naver.com"),HomePinDetailResponseDTO(id: 5, category: "PLAY", name: "생일파티", ownerName: "정채은", location: "가양역 9호선", date: "2024-05-23", startAt: "18:00:33", endAt: "23:00:33", maxParticipants: 20, curParticipants: 11, isParticipating: true, isOwner: false, chatLink: "naver.com")]
    
    lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: listCollectionViewFlowLayout)
    private let listCollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setCollectionView()
    }
    
    private func setCollectionView() {
        listCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(HomeDetailCollectionViewCell.self, forCellWithReuseIdentifier: HomeDetailCollectionViewCell.identifier)
        }
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .grayscaleG11
        
        sortTitleLabel.do {
            $0.text = StringLiterals.Home.List.sortRecent
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG02
            $0.isUserInteractionEnabled = false
        }
        
        sortImageView.do {
            $0.image = UIImage(resource: .icArrowDown)
            $0.isUserInteractionEnabled = false
        }
        
        mapButton.do {
            $0.setBackgroundColor(
                .white,
                for: .normal
            )
            $0.setBackgroundColor(
                .grayscaleG04,
                for: .highlighted
            )
            $0.setImage(
                UIImage(resource: .icMapMap),
                for: .normal
            )
            $0.makeShadow(
                radius: 5,
                offset: CGSize(width: 0, height: 0),
                opacity: 0.25
            )
            $0.makeCornerRound(radius: 25.adjusted)
        }
        
        sortMoreView.do {
            $0.isHidden = true
            $0.talkTitleLabel.text = StringLiterals.Home.List.sortRecent
            $0.deleteTitleLabel.text = StringLiterals.Home.List.sortImminent
            $0.deleteImageView.isHidden = true
            $0.talkImageView.isHidden = true
        }
        
        listCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = .init(top: 0, left: 24.adjustedWidth, bottom: 8, right: 24.adjustedWidth)
        }
        
        listCollectionViewFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12.adjustedWidth
            $0.itemSize = CGSize(
                width: UIScreen.main.bounds.width - 48.adjustedWidth,
                height: 327
            )
        }
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        view.addSubviews(sortButton,
                         listCollectionView,
                         mapButton,
                         sortMoreView)
        
        sortButton.addSubviews(sortTitleLabel,
                               sortImageView)
        
        sortTitleLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        sortImageView.snp.makeConstraints {
            $0.top.centerY.trailing.equalToSuperview()
            $0.size.equalTo(24)
            $0.leading.equalTo(sortTitleLabel.snp.trailing)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(159)
            $0.trailing.equalToSuperview().inset(24.adjustedWidth)
        }
        
        sortMoreView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(4.adjustedHeight)
            $0.trailing.equalTo(sortButton)
            $0.width.equalTo(99)
        }
        
        listCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints {
            $0.width.height.equalTo(50.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview().inset(30.adjustedHeight)
        }
    }
    
    private func setAddTarget() {
        sortButton.addTarget(
            self,
            action: #selector(sortButtonTapped),
            for: .touchUpInside
        )
        sortMoreView.talkButton.addTarget(
            self,
            action: #selector(recentButtonTapped),
            for: .touchUpInside
        )
        sortMoreView.deleteButton.addTarget(
            self,
            action: #selector(imminentButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func sortButtonTapped() {
        sortMoreView.isHidden.toggle()
    }
    
    @objc private func recentButtonTapped() {
        // Reload
        sortTitleLabel.text = StringLiterals.Home.List.sortRecent
        sortMoreView.isHidden = true
    }
    
    @objc private func imminentButtonTapped() {
        // Reload
        sortTitleLabel.text = StringLiterals.Home.List.sortImminent
        sortMoreView.isHidden = true
    }
}

extension HomeListViewController: UICollectionViewDelegate { }

extension HomeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeDetailCollectionViewCell.identifier,
            for: indexPath) as? HomeDetailCollectionViewCell else {return UICollectionViewCell()}
        cell.mapDetailView.dataBind(data: listDummy[indexPath.row])
        return cell
    }
}

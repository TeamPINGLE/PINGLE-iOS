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
    let rankingView = RankingView()
    private let refreshControl = UIRefreshControl()
    private var meetingCount: Int?
    var rankingResponseDTO: [RankingResponseDTO.Location] = []
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setTarget()
        setRegister()
        rankingList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        rankingList()
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self, name: .updateRanking, object: nil)
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
        
        refreshControl.do {
            rankingView.rankingCollectionView.refreshControl = $0
            $0.addTarget(self,
                         action: #selector(refreshRankingView(refresh:)),
                         for: .valueChanged)
        }
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        
        self.view.addSubviews(titleLabel,
                              rankingView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(59)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        rankingView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight)
        }
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
    
    private func setTarget() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRankingViewNotification), name: .updateRanking, object: nil)
    }
    
    private func setupRefreshControl() {
        rankingList { _ in
            self.rankingView.rankingCollectionView.reloadData()
        }
    }
    
    @objc private func refreshRankingView(refresh: UIRefreshControl) {
        refresh.beginRefreshing()
        setupRefreshControl()
        refresh.endRefreshing()
    }
    
    @objc private func handleRankingViewNotification() {
        rankingList { _ in
            self.rankingView.rankingCollectionView.reloadData()
        }
    }
    
    func rankingList(completion: @escaping (Bool) -> Void = { _ in }) {
        guard let userGroupId = KeychainHandler.shared.userGroupId else { return }
        NetworkService.shared.rankingService.ranking(teamId: userGroupId) { [weak self] response in
            switch response {
            case .success(let data):
                guard let rankingList = data.data else {
                    print("No data in response.")
                    return
                }
                
                self?.meetingCount = rankingList.meetingCount
                /// meetingCount가 30 이상이면 배열에 데이터 추가 및 emptyLabel hidden
                if let meetingCount = self?.meetingCount, meetingCount >= 30 {
                    self?.rankingResponseDTO = rankingList.locations
                    self?.rankingView.emptyRankingLabel.isHidden = true
                } else {
                    self?.rankingResponseDTO = []
                    self?.rankingView.emptyRankingLabel.isHidden = false
                }
                
                DispatchQueue.main.async {
                    self?.rankingView.rankingCollectionView.reloadData()
                }
            default:
                print("실패")
                break
            }
        }
    }
}

// MARK: - extension
// MARK: UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        AmplitudeInstance.shared.track(eventType: .scrollRanking)
    }
}

// MARK: UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingResponseDTO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCollectionViewCell.identifier,
                                                            for: indexPath) as? RankingCollectionViewCell else {return UICollectionViewCell()}
        let rankingData = rankingResponseDTO[indexPath.item]
        cell.bindData(data: rankingData, rankingLabel: indexPath.row + 1)
        
        return cell
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
        let labelHeight = calculateDynamicHeight(placeNameText: rankingResponseDTO[indexPath.row].name)
        return CGSize(width: 341.adjusted, height: labelHeight + 76)
    }
    
    func calculateDynamicHeight(placeNameText: String) -> CGFloat {
        let placeNameLabel = UILabel()
        placeNameLabel.text = placeNameText
        placeNameLabel.numberOfLines = 2
        placeNameLabel.preferredMaxLayoutWidth = 270.adjusted
        placeNameLabel.font = .bodyBodySemi14
        placeNameLabel.setTextWithLineHeight(text: placeNameText, lineHeight: 20)

        let placeNameSize = placeNameLabel.sizeThatFits(CGSize(width: 270.adjusted, height: CGFloat.greatestFiniteMagnitude))

        return placeNameSize.height
    }
}

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
    // TODO: 카드 접기 UI
    
    // MARK: - Variables
    // MARK: Component
    private let sortButton = UIButton()
    private let sortTitleLabel = UILabel()
    private let sortImageView = UIImageView()
    private let sortMoreView = MoreView()
    let mapButton = UIButton()
    let emptyLabel = UILabel()
    
    var listData = HomeListSearchResponseDTO(searchCount: 0, meetings: [])
    var searchText: String = ""
    var category: String = ""
    var order: String = "NEW"
    var currentMeetingId: Int = 0
    
    private let refreshControl = UIRefreshControl()
    lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: listCollectionViewFlowLayout)
    private let listCollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var participantsAction: (() -> Void) = {}
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setCollectionView()
        getListData(text: searchText, category: category, order: order)
    }
    
    private func setCollectionView() {
        listCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(HomeListCollectionViewCell.self, forCellWithReuseIdentifier: HomeListCollectionViewCell.identifier)
        }
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .grayscaleG11
        
        emptyLabel.do {
            $0.text = StringLiterals.Home.List.emptyList
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
            $0.setLineSpacing(spacing: 7)
            $0.numberOfLines = 0
            $0.isHidden = true
        }
        
        refreshControl.do {
            listCollectionView.refreshControl = $0
            $0.addTarget(self,
                         action: #selector(refreshCollection(refresh:)),
                         for: .valueChanged)
        }
        
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
            $0.contentInset = .init(top: 0, left: 0, bottom: 8, right: 0)
        }
        
        listCollectionViewFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 12.adjustedWidth
//            $0.itemSize = CGSize(
//                width: UIScreen.main.bounds.width - 48.adjustedWidth,
//                height: 351
//                height: 147
//            )
        }
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        view.addSubviews(sortButton,
                         listCollectionView,
                         mapButton,
                         sortMoreView,
                         emptyLabel)
        
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
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sortButton.snp.bottom).offset(163.adjustedHeight)
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
        order = "NEW"
        getListData(text: searchText, category: category, order: order)
        sortTitleLabel.text = StringLiterals.Home.List.sortRecent
        sortMoreView.isHidden = true
    }
    
    @objc private func imminentButtonTapped() {
        order = "UPCOMING"
        getListData(text: searchText, category: category, order: order)
        sortTitleLabel.text = StringLiterals.Home.List.sortImminent
        sortMoreView.isHidden = true
    }
    
    func getListData(text: String, category: String, order: String) {
        if KeychainHandler.shared.userGroup.count > 0 {
            NetworkService.shared.homeService.listGet(
                queryDTO: HomeListSearchRequestQueryDTO(
                    q: text.isEmpty ? nil : text,
                    category: category,
                    teamId: KeychainHandler.shared.userGroup[0].id,
                    order: order
                )
            ) { [weak self] response in
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    self?.listData = data
                    self?.emptyLabel.isHidden = data.meetings.isEmpty ? false : true
                    self?.listCollectionView.reloadData()
                    print(data)
                default:
                    print("실패")
                    return
                }
            }
        }
    }
    
    // MARK: Objc Function
    @objc private func refreshCollection(refresh: UIRefreshControl) {
        refresh.beginRefreshing()
        getListData(text: searchText, category: category, order: order)
        refresh.endRefreshing()
    }
    
    private func connectTalkLink(urlString: String) {
        print("대화하기 버튼 탭")
        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }
        
        if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            guard let chatURL = URL(string: "https://" + urlString) else {
                print("chatURL error")
                return
            }
            UIApplication.shared.open(chatURL, options: [:], completionHandler: nil)
        }
    }
    
    private func meetingJoin(
        meetingId: Int,
        completion: @escaping (Bool) -> Void
    ) {
        NetworkService.shared.homeService.meetingJoin(meetingId: meetingId) { response in
            switch response {
            case .success:
                print("신청 완료")
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    private func meetingCancel(
        meetingId: Int,
        completion: @escaping (Bool) -> Void
    ) {
        NetworkService.shared.homeService.meetingCancel(meetingId: meetingId) { response in
            switch response {
            case .success:
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    private func meetingDelete(
        meetingId: Int,
        completion: @escaping (Bool) -> Void
    ) {
        NetworkService.shared.homeService.meetingDelete(meetingId: meetingId) { response in
            switch response {
            case .success:
                completion(true)
            default:
                print("실패")
                completion(false)
                return
            }
        }
    }
    
    private func participantCountButtonTapped() {
        participantsAction()
    }
}

extension HomeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
        
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        return true
    }
}

extension HomeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.meetings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeListCollectionViewCell.identifier,
            for: indexPath) as? HomeListCollectionViewCell else {return UICollectionViewCell()}
        cell.homeListDetailView.dataBind(data: listData.meetings[indexPath.row])
        cell.homeListDetailView.updateStyle()
        
        cell.homeListDetailView.participantsButtonAction = {
            cell.showPopUp(
                isParticipating: self.listData.meetings[indexPath.row].isParticipating,
                isOwner: cell.homeListDetailView.isOwner
            )
        }
        
        cell.homeListDetailView.talkButtonAction = {
            self.connectTalkLink(urlString: self.listData.meetings[indexPath.row].chatLink)
        }
        
        cell.homeDetailPopUpView.participantionButtonAction = {
            self.meetingJoin(meetingId: self.listData.meetings[indexPath.row].id) { [weak self] result in
                guard let self else { return }
                if result {
                    cell.homeListDetailView.isParticipating = true
                    getListData(text: searchText, category: category, order: order)
                }
            }
        }
        
        cell.homeDetailCancelPopUpView.cancelButtonAction = {
            if cell.homeListDetailView.isOwner {
                self.meetingDelete(meetingId: self.listData.meetings[indexPath.row].id) { [weak self] result in
                    guard let self else { return }
                    if result {
                        getListData(text: searchText, category: category, order: order)
                    }
                }
            } else {
                self.meetingCancel(meetingId: self.listData.meetings[indexPath.row].id) { [weak self] result in
                    guard let self else { return }
                    if result {
                        cell.homeListDetailView.isParticipating = false
                        getListData(text: searchText, category: category, order: order)
                    }
                }
            }
            self.listCollectionView.reloadData()
        }
        
        cell.homeDetailPopUpView.dataBind(data: listData.meetings[indexPath.row])
        
        cell.memberButtonAction = {
            self.currentMeetingId = cell.homeListDetailView.meetingId
            self.participantCountButtonTapped()
        }
        
        cell.toggleButtonAction = {
            self.listCollectionView.reloadData()
        }
        
        return cell
    }
}

extension HomeListViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: Dynamic height calculation
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeListCollectionViewCell.identifier, for: indexPath) as? HomeListCollectionViewCell else { return .zero }
        
//        cell.frame = CGRect(
//            origin: .zero,
//            size: CGSize(width: collectionView.bounds.width - 48, height: 1000)
//        )
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//        let size = cell.systemLayoutSizeFitting(
//            CGSize(width: collectionView.bounds.width - 48,
//                   height: cell.isExpand ? 351 : 147),
////                   height: 351),
////                   height: .greatestFiniteMagnitude),
//            withHorizontalFittingPriority: .required,
//            verticalFittingPriority: .defaultLow
//        )
//        let maxHeight: CGFloat = 1000 // 원하는 최대 높이 값으로 수정
//        
        let size = CGSize(width: collectionView.bounds.width - 48, height: cell.isExpand ? 351 : 147)
        return size
        }
}

//
//  SoonViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class SoonViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    lazy var myPINGLECollectionView = UICollectionView(frame: .zero, collectionViewLayout: myPINGLEFlowLayout)
    private let myPINGLEFlowLayout = UICollectionViewFlowLayout()
    private let emptyLabel = UILabel()
    private let refreshControl = UIRefreshControl()
    private let deleteToastView = PINGLEWarningToastView()
    
    /// 참여 예정
    private let participant = false
    private var meetingId: Int = 0
    
    // MARK: Property
    var pushToMemberAction: ((Int) -> Void) = {_ in }
    private let homeDimmedTapGesture = UITapGestureRecognizer()
    private var soonMyPINGLEData: [MyPINGLEResponseDTO] = []
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCollectionView()
    }
    
    override func setDelegate() {
        myPINGLECollectionView.delegate = self
        myPINGLECollectionView.dataSource = self
        homeDimmedTapGesture.delegate = self
    }
    
    private func setCollectionView() {
        myPINGLECollectionView.register(
            MyPINGLECollectionViewCell.self,
            forCellWithReuseIdentifier: MyPINGLECollectionViewCell.identifier
        )
    }
    
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
        
        myPINGLEFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 16
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - 48,
                                 height: 229)
        }
        
        myPINGLECollectionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 20,
                                           left: 0,
                                           bottom: 40,
                                           right: 0)
        }
        
        emptyLabel.do {
            $0.text = StringLiterals.MyPingle.List.soonEmpty
            $0.numberOfLines = 2
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
            $0.setLineSpacing(spacing: 2)
            $0.textAlignment = .center
            $0.isHidden = true
        }
        
        refreshControl.do {
            myPINGLECollectionView.refreshControl = $0
            $0.addTarget(self,
                         action: #selector(refreshCollection(refresh:)),
                         for: .valueChanged)
        }  
        
        deleteToastView.do {
            $0.alpha = 0.0
            $0.backgroundColor = .grayscaleG02
            $0.warningImageView.image = UIImage(resource: .icInfoBlack)
            $0.warningLabel.textColor = .black
            $0.warningLabel.text =  StringLiterals.ToastView.deleteMeeting
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        view.addSubviews(myPINGLECollectionView,
                         emptyLabel,
                         deleteToastView)
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        myPINGLECollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteToastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setAddTarget() {
        view.addGestureRecognizer(homeDimmedTapGesture)
    }
    
    // MARK: Objc Function
    @objc private func refreshCollection(refresh: UIRefreshControl) {
        refresh.beginRefreshing()
        showCollectionView()
        refresh.endRefreshing()
    }
    
    private func pushToMemberViewController() {
        pushToMemberAction(meetingId)
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
    
    private func updateCollectionView() {
        emptyLabel.isHidden = !soonMyPINGLEData.isEmpty
    }
    
    // MARK: Server Function
    private func myList(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.myPingleService.myList(queryDTO: MyPINGLEListRequestQueryDTO(participation: participant)) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                self?.soonMyPINGLEData = data
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    private func showCollectionView() {
        myList() { _ in
            self.myPINGLECollectionView.reloadData()
            self.updateCollectionView()
        }
    }
    
    private func meetingCancel(meetingId: Int,
                               isOwner: Bool,
                               completion: @escaping (Bool) -> Void) {
        if isOwner {
            NetworkService.shared.homeService.meetingDelete(meetingId: meetingId) { response in
                switch response {
                case .success:
                    print("핑글 삭제 완료")
                    completion(true)
                    NotificationCenter.default.post(
                        name: .updatePinAndList,
                        object: nil,
                        userInfo: nil)
                default:
                    print("실패")
                    completion(false)
                    return
                }
            }
            AmplitudeInstance.shared.track(eventType: .clickSoonpingleMoreDelete)
        } else {
            NetworkService.shared.homeService.meetingCancel(meetingId: meetingId) { response in
                switch response {
                case .success(let data):
                    if data.code == 200 {
                        print("신청 취소 완료")
                        completion(true)
                    } else if data.code == 404 && data.message == StringLiterals.ErrorMessage.notFoundMember {
                       self.meetingNotFound()
                        completion(true)
                   }
                default:
                    print("실패")
                    completion(false)
                    return
                }
            }
            AmplitudeInstance.shared.track(eventType: .clickSoonpingleMoreCancel)
            NotificationCenter.default.post(
                name: .updatePinAndList,
                object: nil,
                userInfo: nil)
        }
    }
    
    private func meetingNotFound() {
        self.deleteToastView.fadeIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.deleteToastView.fadeOut()
        }
    }
}
// MARK: - extension
// MARK: UICollectionViewDelegate
extension SoonViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        AmplitudeInstance.shared.track(eventType: .scrollSoonpingle)
    }
}

// MARK: UICollectionViewDataSource
extension SoonViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return soonMyPINGLEData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyPINGLECollectionViewCell.identifier,
            for: indexPath
        ) as? MyPINGLECollectionViewCell else { return UICollectionViewCell() }
        
        cell.dataBind(data: soonMyPINGLEData[indexPath.row])
        cell.isMoreViewAppear = false
        
        cell.memberButtonAction = {
            self.meetingId = cell.meetingId
            self.pushToMemberViewController()
            AmplitudeInstance.shared.track(eventType: .clickSoonpingleParticipants)
        }
        
        cell.homeDetailCancelPopUpView.cancelButtonAction = {
            self.meetingCancel(
                meetingId: cell.meetingId,
                isOwner: cell.isOwner
            ) { _ in
                cell.dimmedView.isHidden = true
                cell.homeDetailCancelPopUpView.isHidden = true
                if let index = self.myPINGLECollectionView.indexPath(for: cell) {
                    self.soonMyPINGLEData.remove(at: index.row)
                    self.myPINGLECollectionView.performBatchUpdates(
                        {
                            self.myPINGLECollectionView.deleteItems(at: [index])
                        }, completion: { _ in
                            self.showCollectionView()
                        }
                    )
                }
            }
        }
        
        cell.talkButtonAction = {
            self.connectTalkLink(urlString: cell.myPINGLECardView.openChatURL ?? "https://www.naver.com")
            AmplitudeInstance.shared.track(eventType: .clickSoonpingleMoreChat)
        }
        return cell
    }
}

// MARK: UIGestureRecognizerDelegate
extension SoonViewController: UIGestureRecognizerDelegate {
    /// 다른 뷰 탭 되었을 때 메소드
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        guard let touchView = touch.view else {
            return true
        }
        
        for cell in myPINGLECollectionView.visibleCells {
            if let myPINGLECell = cell as? MyPINGLECollectionViewCell,
               !myPINGLECell.moreView.isHidden {
                if touchView == myPINGLECell.moreView || touchView == myPINGLECell.myPINGLECardView.moreButton || touchView.isDescendant(of: myPINGLECell.moreView) {
                    return false
                } else {
                    myPINGLECell.isMoreViewAppear = false
                }
            }
        }
        return true
    }
}

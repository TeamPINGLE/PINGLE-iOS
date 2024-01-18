//
//  CompleteViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class CompleteViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    lazy var myPINGLECompleteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: myPINGLECompleteFlowLayout)
    private let myPINGLECompleteFlowLayout = UICollectionViewFlowLayout()
    private let emptyLabel = UILabel()
    private let refreshControl = UIRefreshControl()
    /// 참여 완료
    private let participant = true
    
    // MARK: Property
    var pushToCompleteMemberAction: (() -> Void) = {}
    private let homeDimmedTapGesture = UITapGestureRecognizer()
    private var completeMyPINGLEData: [MyPINGLEResponseDTO] = []
    
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
        self.myPINGLECompleteCollectionView.delegate = self
        self.myPINGLECompleteCollectionView.dataSource = self
        self.homeDimmedTapGesture.delegate = self
    }
    
    private func setCollectionView() {
        self.myPINGLECompleteCollectionView.register(MyPINGLECollectionViewCell.self, forCellWithReuseIdentifier: MyPINGLECollectionViewCell.identifier)
    }
    
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
        
        myPINGLECompleteFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 16
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 229)
        }
        
        myPINGLECompleteCollectionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
        }
        
        emptyLabel.do {
            $0.text = StringLiterals.MyPingle.List.completeEmpty
            $0.numberOfLines = 2
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
            $0.setLineSpacing(spacing: 2)
            $0.textAlignment = .center
            $0.isHidden = true
        }
        
        refreshControl.do {
            myPINGLECompleteCollectionView.refreshControl = $0
            $0.addTarget(self, action: #selector(refreshCollection(refresh:)), for: .valueChanged)
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        view.addSubviews(myPINGLECompleteCollectionView,
                         emptyLabel)
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        myPINGLECompleteCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setAddTarget() {
        self.view.addGestureRecognizer(homeDimmedTapGesture)
    }
    
    // MARK: Objc Function
    @objc func refreshCollection(refresh: UIRefreshControl) {
        refresh.beginRefreshing()
        self.showCollectionView()
        refresh.endRefreshing()
    }
    
    private func pushToMemberViewController() {
        pushToCompleteMemberAction()
    }
    
    private func updateCollectionView() {
        emptyLabel.isHidden = !completeMyPINGLEData.isEmpty
    }
    
    // MARK: Server Function
    func myList(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.myPingleService.myList(queryDTO: MyPINGLEListRequestQueryDTO(participation: self.participant)) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                self?.completeMyPINGLEData = data
                completion(true)
            default:
                completion(false)
            }
        }
    }
    
    private func showCollectionView() {
        self.myList() { _ in
            self.myPINGLECompleteCollectionView.reloadData()
            self.updateCollectionView()
        }
    }
}

// MARK: - extension
// MARK: UICollectionViewDelegate
extension CompleteViewController: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource
extension CompleteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return completeMyPINGLEData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPINGLECollectionViewCell.identifier, for: indexPath) as? MyPINGLECollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: completeMyPINGLEData[indexPath.row])
        cell.myPINGLECardView.moreButton.isHidden = true
        cell.setDoneStyle()
        cell.isMoreViewAppear = false
        
        cell.memberButtonAction = {
            self.pushToMemberViewController()
        }
        return cell
    }
}

// MARK: UIGestureRecognizerDelegate
extension CompleteViewController: UIGestureRecognizerDelegate {
    /// 다른 뷰 탭 되었을 때 메소드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchView = touch.view else {
            return true
        }
        
        for cell in myPINGLECompleteCollectionView.visibleCells {
            if let myPINGLECell = cell as? MyPINGLECollectionViewCell, !myPINGLECell.moreView.isHidden {
                if touchView == myPINGLECell.moreView || touchView.isDescendant(of: myPINGLECell.moreView) {
                    return false
                } else {
                    myPINGLECell.isMoreViewAppear = false
                }
            }
        }
        return true
    }
}

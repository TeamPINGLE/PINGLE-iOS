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
    
    lazy var myPINGLECollectionView = UICollectionView(frame: .zero, collectionViewLayout: myPINGLEFlowLayout)
    let myPINGLEFlowLayout = UICollectionViewFlowLayout()
    let emptyLabel = UILabel()
    let refreshControl = UIRefreshControl()
    
    var pushToMemberAction: (() -> Void) = {}
    
    var soonMyPINGLEData: [MyPINGLEResponseDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCollectionView()
    }
    
    override func setDelegate() {
        self.myPINGLECollectionView.delegate = self
        self.myPINGLECollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        self.myPINGLECollectionView.register(MyPINGLECollectionViewCell.self, forCellWithReuseIdentifier: MyPINGLECollectionViewCell.identifier)
    }
    
    override func setStyle() {
        view.backgroundColor = .grayscaleG11
        
        myPINGLEFlowLayout.do {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 16
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 229)
        }
        
        myPINGLECollectionView.do {
            $0.backgroundColor = .grayscaleG11
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
        }
        
        emptyLabel.do {
            $0.text = StringLiterals.MyPingle.List.soonEmpty
            $0.numberOfLines = 2
            $0.font = .subtitleSubSemi18
            $0.textColor = .grayscaleG06
            $0.setLineSpacing(spacing: 2)
            $0.textAlignment = .center
        }
        
        refreshControl.do {
            myPINGLECollectionView.refreshControl = $0
            $0.addTarget(self, action: #selector(refreshCollection(refresh:)), for: .valueChanged)
        }
    }
    
    override func setLayout() {
        view.addSubviews(myPINGLECollectionView,
                         emptyLabel)
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        myPINGLECollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Objc Function
    @objc func refreshCollection(refresh: UIRefreshControl) {
        refresh.beginRefreshing()
        print("새로고침 하는 동안 서버통신")
        refresh.endRefreshing()
    }
    
    private func pushToMemberViewController() {
        pushToMemberAction()
    }
    
    func connectTalkLink(urlString: String) {
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
}

extension SoonViewController: UICollectionViewDelegate { }

extension SoonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPingleDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPINGLECollectionViewCell.identifier, for: indexPath) as? MyPINGLECollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: myPingleDummy[indexPath.row])
        
        cell.memberButtonAction = {
            self.pushToMemberViewController()
        }
        
        cell.homeDetailCancelPopUpView.cancelButtonAction = {
            print("추후 취소 서버통신 연결")
        }
        
        cell.talkButtonAction = {
            self.connectTalkLink(urlString: cell.myPINGLECardView.openChatURL ?? "https://www.naver.com")
        }
        return cell
    }
}

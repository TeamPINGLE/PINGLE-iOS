//
//  ParticipantsListViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class ParticipantsListViewController: BaseViewController {
    
    // MARK: Property
    private let backButton = UIButton()
    private let participantsListTitle = UILabel()
    var participantsListResponseDTO: [String] = []
    var meetingIdentifier: Int = 0
    
    var participantsListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setRegister()
        addTarget()
        participantsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        self.participantsListCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = .init(top: 0, left: 0, bottom: 40, right: 0)
        }
        
        self.backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        self.participantsListTitle.do {
            $0.text = StringLiterals.Home.Participants.participationTitle
            $0.font = .subtitleSubSemi18
            $0.textColor = .white
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, participantsListTitle, participantsListCollectionView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        participantsListTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalTo(backButton.snp.trailing).offset(115.adjusted)
        }
        
        participantsListCollectionView.snp.makeConstraints {
            $0.top.equalTo(participantsListTitle.snp.bottom).offset(35.adjusted)
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Func
    // MARK: Delegate
    override func setDelegate() {
        self.participantsListCollectionView.delegate = self
        self.participantsListCollectionView.dataSource = self
    }
    
    // MARK: Register
    func setRegister() {
        self.participantsListCollectionView.register(ParticipantsCollectionViewCell.self,
                                                                  forCellWithReuseIdentifier: ParticipantsCollectionViewCell.identifier)
    }
    
    func addTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func participantsList() {
        NetworkService.shared.homeService.participantsList(meetingId: meetingIdentifier) { [weak self] response in
            switch response {
            case .success(let data):
                guard let participantsList = data.data else {
                    print("No data in response.")
                    return
                }
                self?.participantsListResponseDTO = participantsList.participants
                
                DispatchQueue.main.async {
                    self?.participantsListCollectionView.reloadData()
                }
            default:
                print("실패")
                return
            }
        }
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension
// MARK: UICollectionViewDelegate
extension ParticipantsListViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource
extension ParticipantsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participantsListResponseDTO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipantsCollectionViewCell.identifier,
                                                            for: indexPath) as? ParticipantsCollectionViewCell else {return UICollectionViewCell()}
        let participantData = participantsListResponseDTO[indexPath.item]
        cell.participantsListView.bindData(data: participantData)
        if indexPath.item == 0 {
            cell.participantsListView.setOwnerCard()
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ParticipantsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 158.adjusted, height: 69)
    }
}

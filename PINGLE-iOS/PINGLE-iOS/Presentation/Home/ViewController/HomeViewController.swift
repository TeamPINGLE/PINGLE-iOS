//
//  HomeViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 2/15/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    var isHomeMap = true
    
    // MARK: Component
    private let homeMapViewController = HomeMapViewController()
    private let homeListViewController = HomeListViewController()
    
    let chipStackView = UIStackView()
    
    private let playChipButton = ChipButton(state: .play)
    private let studyChipButton = ChipButton(state: .study)
    private let multiChipButton = ChipButton(state: .multi)
    private let othersChipButton = ChipButton(state: .others)
    
    lazy var chipButtons: [ChipButton] = [playChipButton,
                                          studyChipButton,
                                          multiChipButton,
                                          othersChipButton]
    
    private let homeGroupLabel = UILabel()
    private let searchButton = UIButton()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    // MARK: Target Helpers
    private func setAddTarget() {
        homeMapViewController.mapsView.listButton.addTarget(
            self,
            action: #selector(mapListButtonTapped),
            for: .touchUpInside
        )
        homeListViewController.mapButton.addTarget(
            self,
            action: #selector(mapListButtonTapped),
            for: .touchUpInside
        )
        chipButtons.forEach {
            $0.addTarget(
                self,
                action: #selector(isChipButtonTapped),
                for: .touchUpInside
            )
        }
        
        homeMapViewController.participantsAction = {
            self.pushParticipantsViewController(meetingId: self.homeMapViewController.currentMeetingId)
        }
        
        homeListViewController.participantsAction = {
            self.pushParticipantsViewController(meetingId: self.homeListViewController.currentMeetingId)
        }
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
        
        homeGroupLabel.do {
            if !KeychainHandler.shared.userGroup.isEmpty {
                $0.text = KeychainHandler.shared.userGroup[0].name
            }
            $0.font = .titleTitleSemi20
            $0.textColor = .white
        }
        
        searchButton.do {
            $0.setImage(UIImage(resource: .icSearch), for: .normal)
        }
        
        chipStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4.adjustedWidth
        }
    }
    
    // MARK: Layout Helpers
    override func setLayout() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 60
        
        view.addSubviews(homeMapViewController.view,
                         homeListViewController.view,
                         homeGroupLabel,
                         searchButton,
                         chipStackView)
        
        chipButtons.forEach {
            chipStackView.addArrangedSubview($0)
        }
        
        homeMapViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        homeListViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaHeight).offset(-tabBarHeight)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24.adjustedWidth)
            $0.top.equalToSuperview().inset(62)
        }
        
        homeGroupLabel.snp.makeConstraints {
            $0.centerY.equalTo(searchButton)
            $0.leading.equalToSuperview().inset(24.adjustedWidth)
            $0.trailing.equalToSuperview().inset(152.adjustedWidth)
        }
        
        chipStackView.snp.makeConstraints {
            $0.top.equalTo(homeGroupLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: @objc Func
    @objc private func mapListButtonTapped() {
        isHomeMap.toggle()
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
    }
    
    @objc private func isChipButtonTapped(sender: ChipButton) {
        /// 태그 선택 여부 반전
        sender.isButtonSelected.toggle()
        
        /// 서버 통신
        if sender.isButtonSelected {
            homeMapViewController.pinList(category: sender.chipStatusString) { [weak self] result in
                guard let self else { return }
                if result {
                    homeMapViewController.setMarker()
                }
            }
            homeMapViewController.markerCategory = sender.chipStatusString
            homeListViewController.category = sender.chipStatusString
        } else {
            homeMapViewController.pinList(category: "") { [weak self] result in
                guard let self else { return }
                if result {
                    homeMapViewController.setMarker()
                }
            }
            homeMapViewController.markerCategory = ""
            homeListViewController.category = ""
        }
        
        /// 태그 하나만 선택할 수 있도록
        chipButtons.filter { $0 != sender }.forEach {
            $0.isButtonSelected = false
        }
        
        /// 모든 마커 (핀) 다 보이도록
        homeMapViewController.mapsView.homeMarkerList.forEach {
            $0.hidden = false
        }
        
        homeMapViewController.hideSelectedPin()
        homeListViewController.getListData(
            text: homeListViewController.searchText,
            category: homeListViewController.category,
            order: homeListViewController.order
        )
    }
    
    // MARK: Custom Func
    private func pushParticipantsViewController(meetingId: Int) {
        let participantsListViewController = ParticipantsListViewController()
        participantsListViewController.meetingIdentifier = meetingId
        navigationController?.pushViewController(
            participantsListViewController,
            animated: true
        )
    }
}

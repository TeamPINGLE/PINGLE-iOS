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
    var isHomeMap = true {
        didSet {
            setMapState()
        }
    }
    var isSearchResult = false
    
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
    private let backButton = UIButton()
    private let searchButton = UIButton()
    private let clearButton = UIButton()
    private let searchView = UIView()
    private let searchTextField = UITextField()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setResult()
        setAddTarget()
        setNavigation()
        setTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBar()
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
        
        homeMapViewController.updateIsHomeMapAction = {
            [weak self]  in
            self?.isHomeMap = false
            self?.homeListViewController.setEmptyView()
        }
        
        searchButton.addTarget(self,
                               action: #selector(searchButtonTapped),
                               for: .touchUpInside)
        
        clearButton.addTarget(self,
                              action: #selector(clearButtonTapped),
                              for: .touchUpInside)
        
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
        
        homeGroupLabel.do {
            if let userGroupName = KeychainHandler.shared.userGroupName {
                $0.text = userGroupName
            }
            $0.font = .titleTitleSemi20
            $0.textColor = .white
        }
        
        searchButton.do {
            $0.setImage(UIImage(resource: .icSearch), for: .normal)
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
            $0.isHidden = true
        }
        
        searchView.do {
            $0.backgroundColor = .grayscaleG10
            $0.layer.cornerRadius = 8
            $0.isHidden = true
        }
        
        searchTextField.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .white
            $0.tintColor = .mainPingleGreen
            $0.isUserInteractionEnabled = false
            $0.isHidden = true
        }
        
        clearButton.do {
            $0.setImage(UIImage(resource: .btnClear), for: .normal)
            $0.isHidden = true
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
                         chipStackView,
                         searchView,
                         backButton)
        
        searchView.addSubviews(searchTextField,
                               clearButton)
        
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
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(49.adjusted)
            $0.trailing.equalToSuperview().inset(24.adjusted)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(13.adjusted)
            $0.trailing.equalToSuperview().inset(53.adjusted)
        }
        
        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(13.adjusted)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    // MARK: @objc Func
    @objc private func mapListButtonTapped() {
        AmplitudeInstance.shared.track(eventType: isHomeMap ? .clickListMap : .clickMapList)
        isHomeMap.toggle()
    }
    
    @objc private func isChipButtonTapped(sender: ChipButton) {
        // 태그 선택 여부 반전
        sender.isButtonSelected.toggle()
        
        // 서버 통신
        if sender.isButtonSelected {
            let q = isSearchResult ? homeListViewController.searchText : ""
            homeMapViewController.pinList(category: sender.chipStatusString, q: q) { [weak self] result in
                guard let self = self else { return }
                if result {
                    homeMapViewController.setMarker()
                }
            }
            homeMapViewController.markerCategory = sender.chipStatusString
            homeListViewController.category = sender.chipStatusString
            
            AmplitudeInstance.shared.track(eventType: isHomeMap ? .clickCategoryMap : .clickCategoryList,
                                           eventProperties: [AmplitudePropertyType.category : sender.chipStatusString])
        } else {
            let q = isSearchResult ? homeListViewController.searchText : ""
            homeMapViewController.pinList(category: "", q: q) { [weak self] result in
                guard let self = self else { return }
                if result {
                    homeMapViewController.setMarker()
                }
            }
            homeMapViewController.markerCategory = ""
            homeListViewController.category = ""
        }
        
        // 태그 하나만 선택할 수 있도록
        chipButtons.filter { $0 != sender }.forEach {
            $0.isButtonSelected = false
        }
        
        // 모든 마커 (핀) 다 보이도록
        homeMapViewController.mapsView.homeMarkerList.forEach {
            $0.hidden = false
        }
        
        homeMapViewController.hideSelectedPin()
        homeListViewController.getListData(
            text: homeListViewController.searchText,
            category: homeListViewController.category,
            order: homeListViewController.order
        ) {}
    }
    
    @objc private func searchButtonTapped() {
        let searchViewController = SearchPINGLEViewController()
        searchViewController.isMap = isHomeMap
        self.navigationController?.pushViewController(searchViewController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.resetChipSelected()
        }
        AmplitudeInstance.shared.track(eventType: isHomeMap ? .clickSearchMap : .clickSearchList)
    }
    
    @objc private func clearButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
    
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setMapState() {
        homeMapViewController.view.isHidden = !isHomeMap
        homeListViewController.view.isHidden = isHomeMap
    }
    
    func resetChipSelected() {
        chipButtons.forEach {
            $0.isButtonSelected = false
        }
        
        homeMapViewController.mapsView.homeMarkerList.forEach {
            $0.hidden = false
        }
        
        // 여기서 모든 핀을 다시 표시하도록  처리
        let q = isSearchResult ? homeListViewController.searchText : ""
        homeMapViewController.pinList(category: "", q: q) { [weak self] result in
            guard let self = self else { return }
            if result {
                self.homeMapViewController.setMarker()
            }
        }
        homeMapViewController.markerCategory = ""
        
        homeListViewController.getListData(
            text: homeListViewController.searchText,
            category: "",
            order: homeListViewController.order
        ) {}
    }

    func getHomeListViewController() -> HomeListViewController {
        return homeListViewController
    }
    
    func getHomeMapViewController() -> HomeMapViewController {
        return homeMapViewController
    }
    
    private func setResult() {
        if isSearchResult {
            searchButton.isHidden = true
            homeGroupLabel.isHidden = true
            backButton.isHidden = false
            searchView.isHidden = false
            searchTextField.isHidden = false
            searchTextField.text = isHomeMap ? homeMapViewController.searchText : homeListViewController.searchText
            clearButton.isHidden = false
        }
    }
}

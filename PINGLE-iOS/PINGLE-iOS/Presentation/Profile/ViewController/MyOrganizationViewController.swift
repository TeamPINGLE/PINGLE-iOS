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
    
    // MARK: Variables
    private var selectedOrganizationInfo: MyTeamsResponseDTO?
    private var currentOrganizationInviteCode: String?
    private var myTeamsList: [MyTeamsResponseDTO] = []
    private var changeMyTeamsList: [MyTeamsResponseDTO] = []
    
    // MARK: Component
    private let backButton = UIButton()
    private let currentOrganizationView = CurrentOrganizationView()
    private let separationView = UIView()
    private let myOrganizationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let makeOrganizationButton = UIButton()
    private let warningToastView = PINGLEWarningToastView(warningLabel: StringLiterals.ToastView.impossibleGroup)
    private let dimmedView = UIView()
    private let shareInviteCodePopUpView = ShareInviteCodePopUpView()
    private let changeOrganizationPopUpView = AccountPopUpView()
    private let dimmedTapGesture = UITapGestureRecognizer()
    
    private enum WarningToastMessage {
        case clipBoardCopy
        case changeOrganization
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setAddTarget()
        setRegister()
        getMyTeams()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
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
        
        warningToastView.do {
            $0.alpha = 0.0
        }
        
        makeOrganizationButton.do {
            $0.setTitle(StringLiterals.Profile.ButtonTitle.makeOrganization, for: .normal)
            $0.titleLabel?.font = .captionCapSemi12
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.layer.addBorder(
                [.bottom],
                color: .white,
                width: 1.0,
                frameHeight: 17.0,
                framgeWidth: 124.0
            )
        }
        
        dimmedView.do {
            $0.backgroundColor = .black
            $0.alpha = 0.7
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
        }
        
        shareInviteCodePopUpView.do {
            $0.isHidden = true
        }
        
        changeOrganizationPopUpView.do {
            $0.isHidden = true
        }
    }
    
    override func setLayout() {
        view.addSubviews(currentOrganizationView, 
                         separationView,
                         myOrganizationCollectionView,
                         makeOrganizationButton)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubviews(dimmedView,
                               shareInviteCodePopUpView, 
                               changeOrganizationPopUpView,
                               warningToastView)
        }
        
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
        
        warningToastView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(52)
            $0.centerX.equalToSuperview()
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
            $0.width.equalTo(124)
        }
        
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        shareInviteCodePopUpView.snp.makeConstraints {
            $0.center.equalTo(dimmedView)
        }
        
        changeOrganizationPopUpView.snp.makeConstraints {
            $0.center.equalTo(dimmedView)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        tabBarController?.tabBar.isHidden = true
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
        dimmedTapGesture.delegate = self
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
        currentOrganizationView.lookInviteCodeButton.addTarget(self,
                                                               action: #selector(lookInviteCodeButtonTapped),
                                                               for: .touchUpInside)
        makeOrganizationButton.addTarget(self,
                                         action: #selector(makeOrganizationButtonTapped),
                                         for: .touchUpInside)
        shareInviteCodePopUpView.clipBoardCopyButton.addTarget(self,
                                                               action: #selector(clipBoardCopyButtonTapped),
                                                               for: .touchUpInside)
        shareInviteCodePopUpView.shareButton.addTarget(self,
                                                       action: #selector(shareButtonTapped),
                                                       for: .touchUpInside)
        changeOrganizationPopUpView.backButton.addTarget(self,
                                                         action: #selector(changeOrganizationTapped),
                                                         for: .touchUpInside)
        changeOrganizationPopUpView.changeStateButton.addTarget(self,
                                                                action: #selector(cancelButtonTapped),
                                                                for: .touchUpInside)
        dimmedView.addGestureRecognizer(dimmedTapGesture)
    }
    
    // MARK: Objc Function
    /// 네비게이션 바 backButton 클릭되었을 때 pop 함수 호출
    @objc private func backButtonTapped() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    /// 현재 선택된 단체의 초대코드 보기를 클릭되었을 때 호출되는 함수
    @objc private func lookInviteCodeButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickInviteCode)
        dimmedView.isHidden = false
        shareInviteCodePopUpView.isHidden = false
    }
    
    /// 새로운 단체 추가하러 가기 버튼이 클릭되었을 때 호출되는 함수
    @objc private func makeOrganizationButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickNewGroup)
        let onboardingViewController = OnboardingViewController()
        navigationController?.pushViewController(onboardingViewController, animated: true)
    }
    
    /// 초대코드 공유 팝업창에서 클립보드 복사했을 때 호출되는 함수
    @objc private func clipBoardCopyButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickInviteCodeCopy)
        guard let inviteCode = currentOrganizationInviteCode else { return }
        UIPasteboard.general.string = inviteCode
        showWarningToastView(warningToastMessage: .clipBoardCopy)
    }
    
    /// 초대코드 공유 팝업창에서 공유하기 버튼을 클릭했을 때 호출되는 함수
    @objc private func shareButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickInviteCodeShare)
        guard let organizationName = KeychainHandler.shared.userGroupName,
              let inviteCode = currentOrganizationInviteCode else { return }
        let shareText: String = """
                                Ready to PINGLE?
                                구성원 모두를 위한 위치기반 네트워킹 서비스, PINGLE
                                
                                \(organizationName)에서 초대 메시지를 보냈습니다.
                                핑글 앱을 다운받고, \(organizationName) 사람들을 만나보세요!
                                
                                초대코드 : \(inviteCode)
                                https://apps.apple.com/kr/app/pingle-%ED%95%91%EA%B8%80/id6475423894?l=en-GB
                                """
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)

        activityViewController.excludedActivityTypes = [
            .addToReadingList,
            .airDrop,
            .assignToContact,
            .markupAsPDF,
            .openInIBooks,
            .print,
            .saveToCameraRoll
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    /// 단체 정보 변경 팝업창에서 그룹 변경하기 버튼을 클릭했을 때 호출되는 함수
    @objc private func changeOrganizationTapped() {
        AmplitudeInstance.shared.track(eventType: .clickOtherGroupChange)
        guard let userGroupId = selectedOrganizationInfo?.id,
              let userGroupName = selectedOrganizationInfo?.name else { return }
        
        KeychainHandler.shared.userGroupId = userGroupId
        KeychainHandler.shared.userGroupName = userGroupName
        
        changeCurrentOrganization()
        
        dimmedView.isHidden = true
        changeOrganizationPopUpView.isHidden = true
        showWarningToastView(warningToastMessage: .changeOrganization)
        
        NotificationCenter.default.post(
            name: .updateRanking,
            object: nil,
            userInfo: nil)
    }
    
    /// 단체 정보 변경 팝업창에서 돌아가기 버튼을 클릭했을 때 호출되는 함수
    @objc private func cancelButtonTapped() {
        dimmedView.isHidden = true
        changeOrganizationPopUpView.isHidden = true
    }
    
    // MARK: Network Function
    func getMyTeams() {
        NetworkService.shared.profileService.myTeams() { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                guard let userGroupId = KeychainHandler.shared.userGroupId else { return }
                
                myTeamsList = data
                changeMyTeamsList = data.filter { $0.id != userGroupId }
                
                bindCurrentOrganizationView()
                myOrganizationCollectionView.reloadData()
            default:
                print("myTeams error")
            }
        }
    }
    
    // MARK: Bind Function
    private func bindCurrentOrganizationView() {
        guard let userGroupId = KeychainHandler.shared.userGroupId else { return }
        
        let myTeam = myTeamsList.first { $0.id == userGroupId }
        guard let myTeam = myTeam else { return }
        
        currentOrganizationInviteCode = myTeam.code
        currentOrganizationView.bindData(data: myTeam)
        shareInviteCodePopUpView.bindInviteCode(inviteCode: myTeam.code)
    }
    
    // MARK: Animation Function
    private func showWarningToastView(warningToastMessage: WarningToastMessage, duration: TimeInterval = 2.0) {
        switch warningToastMessage{
        case .clipBoardCopy:
            warningToastView.changeWarningMessage(message: StringLiterals.ToastView.completedCopy, possible: true)
        case .changeOrganization:
            warningToastView.changeWarningMessage(message: StringLiterals.ToastView.changeOrganization, possible: true)
        }
        
        warningToastView.fadeIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.warningToastView.fadeOut()
        }
    }
    
    private func changeCurrentOrganization() {
        guard let userGroupId = KeychainHandler.shared.userGroupId else { return }
        guard let selectedOrganizationInfo = selectedOrganizationInfo else { return }
        
        changeMyTeamsList = myTeamsList.filter { $0.id != userGroupId }
        myOrganizationCollectionView.reloadData()
        
        currentOrganizationView.fadeOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.bindCurrentOrganizationView()
            self.currentOrganizationView.fadeIn()
            self.currentOrganizationView.bindData(data: selectedOrganizationInfo)
        }
    }
    
    // MARK: CalculateHeight Function
    /// 가입된 단체 정보 Cell의 단체명에 따른 높이를 측정하기 위한 함수
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// 변경하고자 하는 그룹의 정보를 local에 저장한 이후 그룹 변경 팝업창을 띄운다.
        AmplitudeInstance.shared.track(eventType: .clickOtherGroup)
        selectedOrganizationInfo = changeMyTeamsList[indexPath.row]
        changeOrganizationPopUpView.makeChangingOrganizationPopUp(organizationName: changeMyTeamsList[indexPath.row].name)
        dimmedView.isHidden = false
        changeOrganizationPopUpView.isHidden = false
    }
}

// MARK: UICollectionViewDataSource
extension MyOrganizationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return changeMyTeamsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyOrganizationCollectionViewCell.identifier,
            for: indexPath
        ) as? MyOrganizationCollectionViewCell else { return UICollectionViewCell() }
        
        cell.bindData(data: changeMyTeamsList[indexPath.row])
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MyOrganizationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = 75 + calculateDynamicHeight(placeNameText: changeMyTeamsList[indexPath.row].name)
        
        return CGSize(width: UIScreen.main.bounds.width - 48, height: cellHeight)
    }
}

extension MyOrganizationViewController: UIGestureRecognizerDelegate {
    /// 딤 뷰 탭 되었을 때 메소드
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        dimmedView.isHidden = true
        shareInviteCodePopUpView.isHidden = true
        changeOrganizationPopUpView.isHidden = true
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

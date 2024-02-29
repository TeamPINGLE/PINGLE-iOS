//
//  CheckOrganizationViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/26/24.
//

import UIKit

import SnapKit
import Then

final class CheckOrganizationViewController: BaseViewController {
    
    // MARK: Variables
    var organizationName: String?
    var representativeEmail: String?
    var keyword: KeywordResponseDTO?
    private var inviteCode: String?
    
    // MARK: Property
    private let backButton = UIButton()
    private let infoButton = UIButton()
    private let titleLabel = UILabel()
    private let organizationInfoView = OrganizationInfoView(type: .make)
    private let bottomCTAButton = PINGLECTAButton(
        title: StringLiterals.CTAButton.makeTitle,
        buttonColor: .grayscaleG08,
        textColor: .grayscaleG10
    )
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        activateBottomCTAButton()
        organizationInfoViewBindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(UIImage(resource: .icArrowLeft), for: .normal)
        }
        
        infoButton.do {
            $0.setImage(UIImage(resource: .icInfoBig), for: .normal)
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.checkOrganizationTitle, lineHeight: 34)
            $0.font = .titleTitleSemi24
            $0.textColor = .white
            $0.textAlignment = .left
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel,
                         organizationInfoView,
                         bottomCTAButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.leading.equalToSuperview().inset(26)
        }
        
        organizationInfoView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setNavigation() {
        self.title = StringLiterals.Onboarding.NavigationTitle.makeOrganizationNavigation
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.subtitleSubSemi18
        ]
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
        
        let customInfoButton = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = customInfoButton
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        infoButton.addTarget(self,
                             action: #selector(infoButtonTapped),
                             for: .touchUpInside)
        bottomCTAButton.addTarget(self,
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func infoButtonTapped() {
        presentMakeGroupGuideViewController()
    }
    
    @objc func bottomCTAButtonTapped() {
        guard let organizationName = organizationName,
              let representativeEmail = representativeEmail,
              let keywordName = keyword?.name else { return }
        
        let bodyDTO = MakeTeamsRequestBodyDTO(
            name: organizationName,
            email: representativeEmail,
            keyword: keywordName
        )
        
        postMakeTeams(bodyDTO: bodyDTO)
    }
    
    // MARK: Present Function
    private func presentMakeGroupGuideViewController() {
        let makeOrganizationGuideViewController = MakeOrganizationGuideViewController()
        makeOrganizationGuideViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(makeOrganizationGuideViewController, animated: true)
    }
    
    // MARK: ActiveButton
    private func activateBottomCTAButton() {
        self.bottomCTAButton.activateButton()
    }
    
    // MARK: BindData
    private func organizationInfoViewBindData() {
        guard let organizationName = organizationName,
              let representativeEmail = representativeEmail,
              let keywordValue = keyword?.value else {
            return
        }
        
        let organizationInfoData = MakeTeamsRequestBodyDTO(name: organizationName,
                                                       email: representativeEmail,
                                                       keyword: keywordValue)
        organizationInfoView.bindMakeData(data: organizationInfoData)
    }
    
    // MARK: Network Function
    func postMakeTeams(bodyDTO: MakeTeamsRequestBodyDTO) {
        NetworkService.shared.onboardingService.makeTeams(bodyDTO: bodyDTO) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                KeychainHandler.shared.userGroupId = data.id
                KeychainHandler.shared.userGroupName = data.name
                inviteCode = data.code
                changeRootViewController()
            default:
                print("error")
            }
        }
    }
    
    // MARK: ChangeRootViewController
    func changeRootViewController() {
        let makeCompletedViewController = MakeCompletedViewController()
        makeCompletedViewController.inviteCode = inviteCode
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: makeCompletedViewController)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CheckOrganizationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//
//  MakeCompletedViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/29/24.
//

import UIKit

import SnapKit
import Then

final class MakeCompletedViewController: BaseViewController {
    
    // MARK: Variables
    var organizationName: String?
    var inviteCode: String?
    
    // MARK: Property
    private let backGroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let organizationLabel = UILabel()
    private let postpositionLabel = UILabel()
    private let welcomeLabel = UILabel()
    private let bottomCTAButton = PINGLECTAButton(
        title: StringLiterals.CTAButton.inviteFriendTitle,
        buttonColor: .grayscaleG01,
        textColor: .black
    )
    private let homeButton = UIButton()
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateBottomCTAButton()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backGroundImageView.do {
            $0.image = UIImage(resource: .imgGroupGraphic)
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.makeCompletedTitle, lineHeight: 45)
            $0.font = .titleTitleSemi32
            $0.textColor = .white
            $0.textAlignment = .left
        }
        
        organizationLabel.do {
            $0.text = organizationName ?? ""
            $0.font = .subtitleSubSemi16
            $0.textColor = .grayscaleG01
        }
        
        postpositionLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.makeCompletedPostPosition
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG03
        }
        
        welcomeLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.welcomMessage
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG03
        }
        
        homeButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.startHome, for: .normal)
            $0.titleLabel?.font = .subtitleSubSemi16
            $0.titleLabel?.textColor = .white
        }
    }
    
    override func setLayout() {
        view.addSubviews(backGroundImageView,
                         titleLabel,
                         organizationLabel,
                         postpositionLabel, 
                         welcomeLabel,
                         bottomCTAButton,
                         homeButton)
        
        if UIScreen.main.bounds.height > 667 {
            backGroundImageView.snp.makeConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(164)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(362)
                $0.width.equalTo(448)
            }
        } else {
            backGroundImageView.snp.makeConstraints {
                $0.height.equalTo(303)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(164)
                $0.leading.trailing.equalToSuperview()
            }
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(126)
            $0.leading.equalToSuperview().inset(24)
        }
        
        organizationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.equalToSuperview().inset(24)
            $0.width.lessThanOrEqualTo(181)
        }
        
        postpositionLabel.snp.makeConstraints {
            $0.leading.equalTo(organizationLabel.snp.trailing)
            $0.centerY.equalTo(organizationLabel)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(organizationLabel.snp.bottom).offset(7)
            $0.leading.equalTo(24)
        }
        
        bottomCTAButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(90)
            $0.centerX.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(102)
            $0.height.equalTo(22)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: Target Function
    private func setTarget() {
        bottomCTAButton.addTarget(self,
                                  action: #selector(bottomCTAButtonTapped),
                                  for: .touchUpInside)
        
        homeButton.addTarget(self,
                                  action: #selector(homeButtonTapped),
                                  for: .touchUpInside)
    }
    
    // MARK: ActiveButton
    private func activateBottomCTAButton() {
        self.bottomCTAButton.activateButton()
    }
    
    // MARK: Objc Function
    @objc func bottomCTAButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickCreateGroupInvite)
        let shareInviteCodeViewController = ShareInviteCodeViewController()
        shareInviteCodeViewController.organizationName = organizationName
        shareInviteCodeViewController.inviteCode = inviteCode
        navigationController?.pushViewController(shareInviteCodeViewController, animated: true)
    }
    
    @objc func homeButtonTapped() {
        AmplitudeInstance.shared.track(eventType: .clickCreateGroupStart)
        let PINGLETabBarController = PINGLETabBarController()
        PINGLETabBarController.view.alpha = 0.0

        self.view.window?.rootViewController = UINavigationController(rootViewController: PINGLETabBarController)
        self.view.window?.makeKeyAndVisible()

        UIView.animate(withDuration: 0.5) {
            PINGLETabBarController.view.alpha = 1.0
        }
    }
}

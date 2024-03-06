//
//  OnboardingViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/2/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingViewController: BaseViewController {
    
    // MARK: Variables
    private var isRootViewController: Bool {
        return navigationController?.viewControllers.first == self
    }
    
    // MARK: Property
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let existingOrganizationButton = UIButton()
    private let makeOrganizationButton = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
        setNavigation()
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
        
        titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.onboarding
            $0.setLineSpacing(spacing: 4)
            $0.font = .titleTitleSemi30
            $0.textColor = .white
            $0.numberOfLines = 0
        }
        
        existingOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.existingOrganization, for: .normal)
            $0.titleLabel?.font = .subtitleSubSemi16
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(UIImage(resource: .imgSearchGraphic), for: .normal)
            $0.alignTextBelow(spacing: 26)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.makeCornerRound(radius: 12)
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
        
        makeOrganizationButton.do {
            $0.setTitle(StringLiterals.Onboarding.ButtonTitle.makeOrganization, for: .normal)
            $0.titleLabel?.font = .subtitleSubSemi16
            $0.setTitleColor(.white, for: .normal)
            $0.setImage(UIImage(resource: .imgCreateGraphic), for: .normal)
            $0.alignTextBelow(spacing: 26)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.lineBreakMode = .byWordWrapping
            $0.makeCornerRound(radius: 12)
            $0.layer.backgroundColor = UIColor.grayscaleG10.cgColor
        }
    }
    
    override func setLayout() {
        view.addSubviews(titleLabel, existingOrganizationButton, makeOrganizationButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(105)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        existingOrganizationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.leading.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(224)
            $0.width.equalTo((UIScreen.main.bounds.size.width - 57.adjusted) / 2)
        }
        
        makeOrganizationButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.trailing.equalToSuperview().inset(24.adjusted)
            $0.height.equalTo(224)
            $0.width.equalTo((UIScreen.main.bounds.size.width - 57.adjusted) / 2)
        }
    }
    
    // MARK: Navigation Function
    private func setNavigationBar() {
        if isRootViewController {
            self.navigationController?.navigationBar.isHidden = true
            self.navigationItem.hidesBackButton = true
        } else {
            self.navigationController?.navigationBar.isHidden = false
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    private func setNavigation() {
        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    // MARK: Target Function
    private func setTarget() {
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        existingOrganizationButton.addTarget(self,
                                             action: #selector(existingOrganizationButtonDidTap),
                                             for: .touchUpInside)
        makeOrganizationButton.addTarget(self, 
                                         action: #selector(makeOrganizationButtonDidTap),
                                         for: .touchUpInside)
    }
    
    // MARK: Objc Function
    /// 네비게이션 바 backButton 클릭되었을 때 pop 함수 호출
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    /// 기존 단체 입장 버튼 클릭되었을 때 호출되는 함수
    @objc func existingOrganizationButtonDidTap() {
        AmplitudeInstance.shared.track(
            eventType: .clickMethodOption,
            eventProperties: [AmplitudePropertyType.option : "existing_group"])
        let searchOrganizationViewController = SearchOrganizationViewController()
        navigationController?.pushViewController(searchOrganizationViewController, animated: true)
    }
    
    /// 새로운 단체 만들기 버튼 클릭되었을 때 호출되는 함수
    @objc func makeOrganizationButtonDidTap() {
        AmplitudeInstance.shared.track(
            eventType: .clickMethodOption,
            eventProperties: [AmplitudePropertyType.option : "create_group"])
        let enterOrganizationInfoViewController = EnterOrganizationInfoViewController()
        navigationController?.pushViewController(enterOrganizationInfoViewController, animated: true)
    }
}

extension OnboardingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

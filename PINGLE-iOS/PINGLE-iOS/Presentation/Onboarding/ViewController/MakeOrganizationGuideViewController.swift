//
//  MakeOrganizationGuideViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/20/24.
//

import UIKit

import SnapKit
import Then

final class MakeOrganizationGuideViewController: BaseViewController {
    
    // MARK: Property
    private let dismissButton = UIButton()
    private let titleLabel = UILabel()
    private let founderNoticeImageView = UIImageView()
    private let founderNoticeTitleLabel = UILabel()
    private let founderNoticeSubTitleLabel = UILabel()
    private let founderNoticeExpTitleLabel = UILabel()
    private let inviteCodeNoticeImageView = UIImageView()
    private let inviteCodeNoticeTitleLabel = UILabel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        dismissButton.do {
            $0.setImage(UIImage(resource: .imgExitButton), for: .normal)
        }
        
        titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.makeOrganizationGuideTitle
            $0.font = .titleTitleSemi20
            $0.textColor = .white
        }
        
        founderNoticeImageView.do {
            $0.image = UIImage(resource: .imgBan)
        }
        
        founderNoticeTitleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.founderNoticeTitle
            $0.font = .subtitleSubSemi16
            $0.textColor = .white
        }
        
        founderNoticeSubTitleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.founderNoticeSubTitle, lineHeight: 17)
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG04
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
        
        founderNoticeExpTitleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.founderNoticeExpTitle, lineHeight: 17)
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG04
            $0.numberOfLines = 2
            $0.textAlignment = .left
        }
        
        inviteCodeNoticeImageView.do {
            $0.image = UIImage(resource: .imgMessage)
        }
        
        inviteCodeNoticeTitleLabel.do {
            $0.setTextWithLineHeight(text: StringLiterals.Onboarding.ExplainTitle.inviteCodeNoticeTitle, lineHeight: 22)
            $0.font = .subtitleSubSemi16
            $0.textColor = .white
            $0.numberOfLines = 3
            $0.textAlignment = .left
        }
    }
    
    override func setLayout() {
        view.addSubviews(dismissButton,
                         titleLabel,
                         founderNoticeImageView,
                         founderNoticeTitleLabel,
                         founderNoticeSubTitleLabel,
                         founderNoticeExpTitleLabel,
                         inviteCodeNoticeImageView,
                         inviteCodeNoticeTitleLabel)
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().inset(18)
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        founderNoticeImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(22)
            $0.size.equalTo(78)
        }
        
        founderNoticeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(founderNoticeImageView)
            $0.leading.equalTo(founderNoticeImageView.snp.trailing).offset(24)
        }
        
        founderNoticeSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(founderNoticeTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(founderNoticeImageView.snp.trailing).offset(24)
        }
        
        founderNoticeExpTitleLabel.snp.makeConstraints {
            $0.top.equalTo(founderNoticeSubTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(founderNoticeImageView.snp.trailing).offset(24)
        }
        
        inviteCodeNoticeImageView.snp.makeConstraints {
            $0.top.equalTo(founderNoticeImageView.snp.bottom).offset(96)
            $0.leading.equalToSuperview().inset(22)
            $0.size.equalTo(78)
        }
        
        inviteCodeNoticeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(inviteCodeNoticeImageView)
            $0.leading.equalTo(inviteCodeNoticeImageView.snp.trailing).offset(24)
        }
    }
    
    // MARK: Target Function
    private func setTarget() {
        dismissButton.addTarget(self,
                             action: #selector(dismissButtonTapped),
                             for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
}

//
//  HomeListViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/7/24.
//

import UIKit

import SnapKit
import Then

final class HomeListViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    let sortButton = UIButton()
    let sortTitleLabel = UILabel()
    let sortImageView = UIImageView()
    let sortMoreView = MoreView()
    let mapButton = UIButton()
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .grayscaleG11
        
        sortTitleLabel.do {
            $0.text = StringLiterals.Home.List.sortRecent
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG02
            $0.isUserInteractionEnabled = false
        }
        
        sortImageView.do {
            $0.image = UIImage(resource: .icArrowDown)
            $0.isUserInteractionEnabled = false
        }
        
        mapButton.do {
            $0.setBackgroundColor(
                .white,
                for: .normal
            )
            $0.setBackgroundColor(
                .grayscaleG04,
                for: .highlighted
            )
            $0.setImage(
                UIImage(resource: .icMapMap),
                for: .normal
            )
            $0.makeShadow(
                radius: 5,
                offset: CGSize(width: 0, height: 0),
                opacity: 0.25
            )
            $0.makeCornerRound(radius: 25.adjusted)
        }
        
        sortMoreView.do {
            $0.isHidden = true
            $0.talkTitleLabel.text = StringLiterals.Home.List.sortRecent
            $0.deleteTitleLabel.text = StringLiterals.Home.List.sortImminent
            $0.deleteImageView.isHidden = true
            $0.talkImageView.isHidden = true
        }
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        view.addSubviews(sortButton,
                         sortMoreView,
                         mapButton)
        
        sortButton.addSubviews(sortTitleLabel,
                               sortImageView)
        
        sortTitleLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        sortImageView.snp.makeConstraints {
            $0.top.centerY.trailing.equalToSuperview()
            $0.size.equalTo(24)
            $0.leading.equalTo(sortTitleLabel.snp.trailing)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(159)
            $0.trailing.equalToSuperview().inset(24.adjustedWidth)
        }
        
        sortMoreView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(4.adjustedHeight)
            $0.trailing.equalTo(sortButton)
            $0.width.equalTo(99)
        }
        
        mapButton.snp.makeConstraints {
            $0.width.height.equalTo(50.adjusted)
            $0.trailing.equalToSuperview().inset(16.adjustedWidth)
            $0.bottom.equalToSuperview().inset(30.adjustedHeight)
        }
    }
    
    private func setAddTarget() {
        sortButton.addTarget(
            self,
            action: #selector(sortButtonTapped),
            for: .touchUpInside
        )
        sortMoreView.talkButton.addTarget(
            self,
            action: #selector(recentButtonTapped),
            for: .touchUpInside
        )
        sortMoreView.deleteButton.addTarget(
            self,
            action: #selector(imminentButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func sortButtonTapped() {
        sortMoreView.isHidden.toggle()
    }
    
    @objc private func recentButtonTapped() {
        // Reload
        sortTitleLabel.text = StringLiterals.Home.List.sortRecent
        sortMoreView.isHidden = true
    }
    
    @objc private func imminentButtonTapped() {
        // Reload
        sortTitleLabel.text = StringLiterals.Home.List.sortImminent
        sortMoreView.isHidden = true
    }
}

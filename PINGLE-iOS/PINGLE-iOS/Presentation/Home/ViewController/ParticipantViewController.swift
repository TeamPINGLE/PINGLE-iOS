//
//  ParticipantViewController.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import UIKit

final class ParticipantViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let fixView = FixView()
    private let backButton = UIButton()
    
    // MARK: - Function
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .grayscaleG11
        
        backButton.do {
            $0.setImage(
              UIImage(resource: .icArrowLeft),
              for: .normal
            )
        }
    }
    
    private func setAddTarget() {
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: Objc Function
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        
        view.addSubviews(backButton,
                         fixView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18)
        }
        
        fixView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(77.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
}

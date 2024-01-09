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
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: Style Helpers
    override func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .grayscaleG11
        
        backButton.do {
            $0.setImage(ImageLiterals.Icon.imgArrowLeft, for: .normal)
        }
    }
    
    private func setAddTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Style Helpers
    override func setLayout() {
        
        self.view.addSubviews(backButton,
                              fixView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18)
        }
        
        fixView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(77.adjustedHeight)
            $0.centerX.equalToSuperview()
        }
    }
}

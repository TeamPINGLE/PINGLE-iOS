//
//  FinalResultViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class FinalResultViewController: BaseViewController {
    
    // MARK: - Property
    let meetingManager = MeetingManager.shared
    private let backButton = UIButton()
    private let progressBar7 = UIImageView()
    private let finalResultTitle = UILabel()
    private let contentsView = UIView()
    private let cardScrollView = UIScrollView()
    private let finalResultCard = FinalSummaryCardView()
    private let nextButton = PINGLECTAButton(title: StringLiterals.Meeting.FinalResult.finalResultButton,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTarget()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setNavigation()
    }
    
    // MARK: - UI
    override func setStyle() {
        self.view.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        backButton.do {
            $0.setImage(ImageLiterals.Meeting.Icon.icBack, for: .normal)
        }
        
        progressBar7.do {
            $0.image = ImageLiterals.Meeting.ProgressBar.progressBarImage7
            $0.contentMode = .scaleAspectFill
        }
        
        finalResultTitle.do {
            $0.setTextWithLineHeight(text: StringLiterals.Meeting.FinalResult.finalResultTitle, lineHeight: 34)
            $0.font = .titleTitleSemi24
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.textColor = .white
        }
        
        cardScrollView.do {
            $0.isScrollEnabled = true
        }
        
        nextButton.do {
            $0.activateButton()
        }
        
        contentsView.do {
            $0.backgroundColor = .grayscaleG11
        }
    }
    
    override func setLayout() {
        self.view.addSubviews(backButton, progressBar7, finalResultTitle, cardScrollView,
                              nextButton)
        cardScrollView.addSubview(contentsView)
        contentsView.addSubview(finalResultCard)
        
        cardScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(finalResultTitle.snp.bottom).offset(13.adjusted)
            $0.bottom.equalTo(nextButton.snp.top).offset(-18.adjustedHeight)
        }
        
        contentsView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(450.adjustedHeight)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        finalResultTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(107.adjusted)
            $0.leading.equalToSuperview().inset(26.adjusted)
        }
        
        finalResultCard.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24.adjusted)
            $0.top.equalToSuperview().inset(12.adjusted)
            $0.height.equalTo(301.adjustedHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjusted)
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.trailing.equalToSuperview().inset(333.adjusted)
        }
        
        progressBar7.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60.adjusted)
            $0.height.equalTo(19)
            $0.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).inset(54.adjusted)
            $0.leading.equalToSuperview().inset(16.adjusted)
        }
    }
    
    // MARK: Objc Function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        self.dismiss(animated: true)
    }
    
    // MARK: Function
    func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
}

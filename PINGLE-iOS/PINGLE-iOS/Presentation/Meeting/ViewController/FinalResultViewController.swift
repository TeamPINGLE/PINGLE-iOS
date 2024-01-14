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
    private let backButton = UIButton()
    private let progressBar7 = UIImageView()
    private let finalResultTitle = UILabel()
    private let contentsView = UIView()
    private let cardScrollView = UIScrollView()
    private let finalResultCard = FinalSummaryCardView()
    private let nextButton = PINGLECTAButton(title: StringLiterals.Meeting.FinalResult.finalResultButton,
                                             buttonColor: .grayscaleG08,
                                             textColor: .grayscaleG10)
    private let formatter = DateFormatter()
    
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
        self.view.addSubviews(backButton, progressBar7, finalResultTitle, cardScrollView, nextButton)
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
        
        let selectedDate = dateFormat(date: MeetingManager.shared.date)
        let selectedStart = timeFormat(time: MeetingManager.shared.startAt)
        let selectedEnd = timeFormat(time: MeetingManager.shared.endAt)
        
        let category = MeetingManager.shared.category
        let name = MeetingManager.shared.name
        let startAt = selectedDate + " " + selectedStart
        let endAt = selectedDate + " " + selectedEnd
        let x = MeetingManager.shared.x
        let y = MeetingManager.shared.y
        let address = MeetingManager.shared.address
        let roadAddress = MeetingManager.shared.roadAddress
        let location = MeetingManager.shared.location
        let maxParticipants = MeetingManager.shared.maxParticipants
        let chatLink = MeetingManager.shared.chatLink

        let meetingData = MakeMeetingRequestBodyDTO(
            category: category,
            name: name,
            startAt: startAt,
            endAt: endAt,
            x: x,
            y: y,
            address: address,
            roadAddress: roadAddress,
            location: location,
            maxParticipants: maxParticipants,
            chatLink: chatLink
        )
        
        print(meetingData)
        makeMeeting(data: meetingData)
        self.dismiss(animated: true)
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: PINGLETabBarController())
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Function
    func setTarget() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func makeMeeting(data: MakeMeetingRequestBodyDTO) {
           NetworkService.shared.meetingService.makeMeeting(bodyDTO: data) { [weak self] response in
               guard let self = self else { return }
               switch response {
               case .success(let result):
                   print("Meeting created successfully. Result: \(result)")
               default:
                   print("not Created")
               }
           }
       }
    
    private func dateFormat(date: Date) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func timeFormat(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: time)
    }
   }

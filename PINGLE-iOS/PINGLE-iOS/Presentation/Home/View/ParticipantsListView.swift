//
//  ParticipantsListView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class ParticipantsListView: BaseView {
    
    // MARK: - Property
    
    let organizer = UILabel()
    var userName = UILabel()
    let cellBackgroundView = UIView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func setStyle() {
        
        self.cellBackgroundView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 10)
        }
        
        self.organizer.do {
            $0.text = StringLiterals.Home.Participants.meetingOwner
            $0.font = .captionCapMed10
            $0.textColor = .mainPingleGreen
            $0.textAlignment = .center
            $0.isHidden = true
        }
        
        self.userName.do {
            $0.text = "정채은강민수방민지짱최고"
            $0.font = .subtitleSubSemi16
            $0.textColor = .grayscaleG03
            $0.lineBreakMode = .byTruncatingTail
            $0.textAlignment = .center
        }
    }
    
    override func setLayout() {
        self.addSubview(cellBackgroundView)
        cellBackgroundView.addSubviews(userName, organizer)
        
        cellBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userName.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15.adjusted)
            $0.top.bottom.equalToSuperview().inset(23)
        }
        
        organizer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(59.adjusted)
        }
    }
    
    func setOwnerCard() {
        organizer.isHidden = false
        userName.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.bottom.equalToSuperview().inset(15.adjusted)
        }
    }
}

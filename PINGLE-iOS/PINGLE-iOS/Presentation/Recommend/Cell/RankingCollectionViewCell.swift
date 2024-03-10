//
//  RankingCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/20/24.
//

import UIKit

class RankingCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "rankingCollectionViewCell"
    
    // MARK: Properties
    private let rankingPinView = RankingNumberView()
    private let rankingView = UIView()
    private let rankingLabel = UILabel()
    private let meetingNumberLabel = UILabel()
    private let placeNameLabel = UILabel()
    private let currentVisitLabel = UILabel()
    private let currentDateLabel = UILabel()
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        rankingView.do {
            $0.backgroundColor = .grayscaleG10
            $0.makeCornerRound(radius: 15)
        }
        
        rankingLabel.do {
            $0.font = .subtitleSubBold16
            $0.textColor = .white
        }
        
        meetingNumberLabel.do {
            $0.font = .captionCapBold10
            $0.textColor = .white
        }
        
        placeNameLabel.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG01
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byCharWrapping
        }
        
        currentVisitLabel.do {
            $0.text = StringLiterals.Recommend.latestVisit
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG04
        }
        
        currentDateLabel.do {
            $0.text = " "
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG03
        }
    }
    
    func setLayout() {
        self.addSubviews(rankingLabel, 
                         rankingView)
        rankingView.addSubviews(rankingPinView, 
                                placeNameLabel,
                                currentVisitLabel,
                                currentDateLabel)
        rankingPinView.addSubview(meetingNumberLabel)
        
        rankingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalToSuperview().inset(7)
        }
        
        rankingView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(31.adjusted)
        }
        
        rankingPinView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        meetingNumberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6.adjusted)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalTo(rankingPinView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(37)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(270.adjusted)
        }
        
        currentVisitLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        currentDateLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(currentVisitLabel.snp.trailing).offset(5.adjusted)
        }
    }
    
    // MARK: Custom Function
    func bindData(data: RankingResponseDTO.Location, rankingLabel: Int) {
        self.rankingLabel.text = "\(rankingLabel)"
        placeNameLabel.text = data.name
        meetingNumberLabel.text = "\(data.locationCount)"
        currentDateLabel.text = convertToDateStr(dateComponents: data.latestVisitedDate)
        
        if data.locationCount < 10 {
            self.rankingPinView.addSubview(meetingNumberLabel)
            meetingNumberLabel.snp.updateConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(10.adjusted)
            }
        } else {
            self.rankingPinView.addSubview(meetingNumberLabel)
            meetingNumberLabel.snp.updateConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(6.adjusted)
            }
        }
    }
}

func convertToDateStr(dateComponents: [Int]) -> String? {
    let year = dateComponents[0]
    let month = dateComponents[1]
    let day = dateComponents[2]
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: "\(year)-\(month)-\(day)")

    if let date = date {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    } else {
        return nil
    }
}

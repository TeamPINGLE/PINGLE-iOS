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
    private let ranking = UILabel()
    private let meetingNumber = UILabel()
    private let placeName = UILabel()
    private let currentVisit = UILabel()
    private let currentDate = UILabel()
    
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
        
        ranking.do {
            $0.font = .captionCapBold12
            $0.textColor = .white
        }
        
        meetingNumber.do {
            $0.font = .captionCapBold10
            $0.textColor = .white
        }
        
        placeName.do {
            $0.font = .bodyBodySemi14
            $0.textColor = .grayscaleG01
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.lineBreakMode = .byCharWrapping
        }
        
        currentVisit.do {
            $0.text = StringLiterals.Recommend.latestVisit
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG04
        }
        
        currentDate.do {
            $0.text = " "
            $0.font = .captionCapMed12
            $0.textColor = .grayscaleG03
        }
    }
    
    func setLayout() {
        self.addSubviews(ranking, 
                         rankingView)
        rankingView.addSubviews(rankingPinView, 
                                placeName,
                                currentVisit,
                                currentDate)
        rankingPinView.addSubview(meetingNumber)
        
        ranking.snp.makeConstraints {
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
        
        meetingNumber.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        placeName.snp.makeConstraints {
            $0.top.equalTo(rankingPinView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(37)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(270.adjusted)
        }
        
        currentVisit.snp.makeConstraints {
            $0.top.equalTo(placeName.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        
        currentDate.snp.makeConstraints {
            $0.top.equalTo(placeName.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalTo(currentVisit.snp.trailing).offset(5.adjusted)
        }
    }
    
    // MARK: Custom Function
    func bindData(data: RankingResponseDTO.Location, ranking: Int) {
        self.ranking.text = "\(ranking)"
        placeName.text = data.name
        meetingNumber.text = "\(data.locationCount)"
        currentDate.text = convertToDateStr(dateComponents: data.latestVisitedDate)
    }
}

func convertToDateStr(dateComponents: [Int]) -> String? {
    guard dateComponents.count == 6 else {
        return nil
    }

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

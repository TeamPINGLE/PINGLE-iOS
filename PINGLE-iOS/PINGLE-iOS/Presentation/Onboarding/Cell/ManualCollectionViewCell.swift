//
//  ManualCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/13/24.
//

import UIKit

import SnapKit
import Then

final class ManualCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ManualCollectionViewCell"
    
    // MARK: Property
    private let manualImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        titleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.manualTitle
            $0.setLineSpacing(spacing: 4)
            $0.font = .titleTitleSemi20
            $0.textColor = .white
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
        
        subTitleLabel.do {
            $0.text = StringLiterals.Onboarding.ExplainTitle.manualSubTitle
            $0.setLineSpacing(spacing: 3)
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG02
            $0.numberOfLines = 2
            $0.textAlignment = .center
        }
    }
    
    func setLayout() {
        self.addSubviews(manualImageView,
                         titleLabel,
                         subTitleLabel)
        
        manualImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(440)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).inset(131)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    func bindData(data: ManualDummyDTO) {
        manualImageView.image = data.manualImage
        titleLabel.text = data.manualTitle
        
        if let subTitle = data.manualSubTitle {
            subTitleLabel.isHidden = false
            subTitleLabel.text = subTitle
            titleLabel.asColor(targetString: "PINGLE", color: .mainPingleGreen)
        } else {
            subTitleLabel.isHidden = true
        }
    }
}

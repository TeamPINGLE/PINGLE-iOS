//
//  ParticipantsCollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class ParticipantsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let identifier = "ParticipantsCollectionViewCell"
    let participantsListView = ParticipantsListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        participantsListView.organizer.isHidden = true
    }
    
    private func setLayout() {
        self.addSubviews(participantsListView)
        
        participantsListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//
//  MyPINGLECollectionViewCell.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import UIKit

import SnapKit
import Then

final class MyPINGLECollectionViewCell: UICollectionViewCell {

    static let identifier = "MyPINGLECollectionViewCell"
    
    let myPINGLECardView = MyPINGLECardView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() { }
    
    private func setLayout() {
        self.addSubviews(myPINGLECardView)
        
        myPINGLECardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

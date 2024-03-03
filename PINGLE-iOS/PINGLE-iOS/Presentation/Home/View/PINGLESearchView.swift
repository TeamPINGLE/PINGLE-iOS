//
//  PINGLESearchView.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 3/2/24.
//

import UIKit

import SnapKit
import Then

final class PINGLESearchView: BaseView {
    
    // MARK: Property
    private let searchGraphicImageView = UIImageView()
    private let searchExplainLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(searchExplainLabel: String) {
        super.init(frame: .zero)
        self.searchExplainLabel.text = searchExplainLabel
        self.searchExplainLabel.asColorArray(targetStringList: ["지도", "리스트"],
                                             color: .mainPingleGreen)
    }
    
    // MARK: UI
    override func setStyle() {
        self.do {
            $0.backgroundColor = .grayscaleG11
        }
        
        searchGraphicImageView.do {
            $0.image = UIImage(resource: .graphicSearch)
            $0.contentMode = .scaleAspectFit
        }
        
        searchExplainLabel.do {
            $0.font = .bodyBodyMed16
            $0.textColor = .grayscaleG02
        }
    }
    
    override func setLayout() {
        self.addSubviews(searchGraphicImageView,
                         searchExplainLabel)
        
        searchGraphicImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(42)
        }
        
        searchExplainLabel.snp.makeConstraints {
            $0.top.equalTo(searchGraphicImageView.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
}

//
//  RankingRespnseDTO.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/20/24.
//

import Foundation

struct RankingRespnseDTO {
    let locationCount: Int
    let name: String
    
    init(locationCount: Int, name: String) {
        self.locationCount = locationCount
        self.name = name
    }
}

var rankingCollectionList: [RankingRespnseDTO] = [.init(locationCount: 20, name: StringLiterals.Recommend.rankingPlace),
                                                  .init(locationCount: 30, name: StringLiterals.Recommend.rankingPlace2),
                                                  .init(locationCount: 20, name: StringLiterals.Recommend.rankingPlace),
                                                  .init(locationCount: 20, name: StringLiterals.Recommend.rankingPlace2)]

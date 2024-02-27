//
//  RankingRespnseDTO.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/20/24.
//

import Foundation

struct RankingResponseDTO: Codable {
    let meetingCount: Int
    let locations: [Location]
    
    struct Location: Codable {
        let name: String
        let latestVisitedDate: [Int]
        let locationCount: Int
    }
}

//
//  HomeListSearchResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 2/25/24.
//

import Foundation

struct HomeListSearchResponseDTO: Codable {
    let searchCount: Int
    let meetings: [HomePinDetailResponseDTO]
}

//
//  HomeListSearchRequestQueryDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 2/25/24.
//

import Foundation

struct HomeListSearchRequestQueryDTO: Codable {
    let q: String?
    let category: String?
    let teamId: Int
    let order: String
}

//
//  HomePinListResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/4/24.
//

import Foundation

struct HomePinListResponseDTO: Codable {
    let id: Int
    let x: Double
    let y: Double
    let category: String
    let meetingCount: Int
}

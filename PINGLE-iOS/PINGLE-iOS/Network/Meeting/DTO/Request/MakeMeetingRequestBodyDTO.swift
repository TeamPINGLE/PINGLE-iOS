//
//  makeMeetingRequestDTO.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/12/24.
//

import Foundation

struct MakeMeetingRequestBodyDTO: Codable {
    let category: String
    let name: String
    let startAt: String
    let endAt: String
    let x: Double
    let y: Double
    let address: String
    let roadAddress: String
    let location: String
    let maxParticipants: Int
    let chatLink: String
}

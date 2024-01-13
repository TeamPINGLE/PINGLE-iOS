//
//  HomePinDetailResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/6/24.
//

import Foundation

struct HomePinDetailResponseDTO: Codable {
    let id: Int
    let category: String
    let name: String
    let ownerName: String
    let location: String
    let date: String
    let startAt: String
    let endAt: String
    let maxParticipants: Int
    let curParticipants: Int
    let isParticipating: Bool
    let isOwner: Bool
    let chatLink: String
}

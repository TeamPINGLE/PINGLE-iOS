//
//  MyPINGLEResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/17/24.
//

import Foundation

struct MyPINGLEResponseDTO: Codable {
    let id: Int
    let category: String
    let name: String
    let ownerName: String
    let location: String
    let dDay: String
    let date: String
    let startAt: String
    let endAt: String
    let maxParticipants: Int
    let curParticipants: Int
    let isOwner: Bool
}

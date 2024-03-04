//
//  MyTeamsResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 3/2/24.
//

import Foundation

struct MyTeamsResponseDTO: Codable {
    let id: Int
    let keyword: String
    let name: String
    let meetingCount: Int
    let participantCount: Int
    let isOwner: Bool
    let code: String
}

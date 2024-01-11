//
//  OrganizationDetailResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/11/24.
//

import Foundation

struct OrganizationDetailResponseDTO: Codable {
    let id: Int
    let keyword: String
    let name: String
    let meetingCount: Int
    let participantCount: Int
}

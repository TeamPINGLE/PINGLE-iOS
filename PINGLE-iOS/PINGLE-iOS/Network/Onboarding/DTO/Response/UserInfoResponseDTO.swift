//
//  UserInfoResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/10/24.
//

import Foundation

struct UserInfoResponseDTO: Codable {
    let id: Int
    let name, email, provider: String?
    let groups: [UserGroup]?
}

struct UserGroup: Codable {
    let id: Int
    let name: String
}

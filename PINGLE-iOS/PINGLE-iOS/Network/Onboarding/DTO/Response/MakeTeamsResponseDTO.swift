//
//  MakeTeamsResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/28/24.
//

import Foundation

struct MakeTeamsResponseDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let keyword: String
    let code: String
}

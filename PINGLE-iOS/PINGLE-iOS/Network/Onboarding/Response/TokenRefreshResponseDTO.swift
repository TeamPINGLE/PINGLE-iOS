//
//  TokenRefreshResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/12/24.
//

import Foundation

struct TokenRefreshResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String
}

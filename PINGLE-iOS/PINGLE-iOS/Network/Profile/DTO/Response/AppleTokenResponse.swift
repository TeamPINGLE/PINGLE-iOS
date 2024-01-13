//
//  AppleTokenResponse.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/12/24.
//

import Foundation

struct AppleTokenResponse: Codable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

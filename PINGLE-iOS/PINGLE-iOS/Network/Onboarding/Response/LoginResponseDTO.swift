//
//  LoginResponseDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/9/24.
//

import Foundation

struct LoginResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String
}

//
//  LoginRequestBodyDTO.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/9/24.
//

import Foundation

struct LoginRequestBodyDTO: Codable {
    let provider: String
    let name: String
}

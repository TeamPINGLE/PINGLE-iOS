//
//  BaseResponse.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let message: String
    let data: T?
}

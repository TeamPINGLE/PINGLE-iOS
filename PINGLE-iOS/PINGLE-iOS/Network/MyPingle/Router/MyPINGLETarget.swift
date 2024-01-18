//
//  MyPINGLETarget.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/18/24.
//

import Foundation

import Alamofire

enum MyPINGLETarget {
    case myList(queryDTO: MyPINGLEListRequestQueryDTO)
}

extension MyPINGLETarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .myList:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .myList:
            return .teamId
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .myList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .myList:
            return "/users/me/meetings"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .myList(let queryDTO):
            return .requestQuery(queryDTO)
        }
    }
}

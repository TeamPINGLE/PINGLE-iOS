//
//  ProfileTarget.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/12/24.
//

import Foundation

import Alamofire

enum ProfileTarget {
    case logout
    case deleteID
}

extension ProfileTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .logout:
            return .authorization
        case .deleteID:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .logout:
            return .hasToken
        case .deleteID:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .logout:
            return .post
        case .deleteID:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        case .deleteID:
            return "/users/leave"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .logout:
            return .requestPlain
        case .deleteID:
            return .requestPlain
        }
    }
}

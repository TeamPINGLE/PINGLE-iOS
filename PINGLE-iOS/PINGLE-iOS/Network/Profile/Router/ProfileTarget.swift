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
    case myTeams
}

extension ProfileTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .logout:
            return .authorization
        case .deleteID:
            return .authorization
        case .myTeams:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .logout:
            return .hasToken
        case .deleteID:
            return .deleteAppleId
        case .myTeams:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .logout:
            return .post
        case .deleteID:
            return .delete
        case .myTeams:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .logout:
            return "/v1/auth/logout"
        case .deleteID:
            return "/v1/users/leave"
        case .myTeams:
            return "/v1/users/me/teams"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .logout:
            return .requestPlain
        case .deleteID:
            return .requestPlain
        case .myTeams:
            return .requestPlain
        }
    }
}

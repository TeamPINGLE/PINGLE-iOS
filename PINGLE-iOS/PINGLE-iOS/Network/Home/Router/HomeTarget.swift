//
//  HomeTarget.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

import Alamofire

enum HomeTarget {
    case pinList(_ teamId: String)
}

extension HomeTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .pinList( _):
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .pinList( _):
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .pinList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .pinList(let teamId):
            return "/teams/\(teamId)/pins"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .pinList(_):
            return .requestPlain
        }
    }
}

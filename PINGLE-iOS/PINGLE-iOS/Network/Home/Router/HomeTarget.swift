//
//  HomeTarget.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

import Alamofire

enum HomeTarget {
    case pinList(_ teamId: Int)
    case pinDetail(_ teamId: Int,_ pinId: Int)
}

extension HomeTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .pinList(_):
            return .authorization
        case .pinDetail(_, _):
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .pinList(_):
            return .hasToken
        case .pinDetail(_, _):
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .pinList:
            return .get
        case .pinDetail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .pinList(let teamId):
            return "/teams/\(teamId)/pins"
        case .pinDetail(let teamId, let pinId):
            return "/teams/\(teamId)/pins/\(pinId)/meetings"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .pinList(_):
            return .requestPlain
        case .pinDetail(_, _):
            return .requestPlain
        }
    }
}

//
//  HomeTarget.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

import Alamofire

enum HomeTarget {
    case pinList(_ teamId: Int, _ queryDTO: HomePinListRequestQueryDTO)
}

extension HomeTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .pinList(_, _):
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .pinList(_, _):
            return .plain
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
        case .pinList(let teamId, _):
            return "/teams/\(teamId)/pins"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .pinList(_, queryDTO):
            return .requestQuery(queryDTO)
        }
    }
}

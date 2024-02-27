//
//  RankingTarget.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 2/24/24.
//

import Foundation

import Alamofire

enum RankingTarget {
    case ranking(_ teamId: Int)
}

extension RankingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .ranking:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .ranking:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .ranking:
            return .get
        }
    }
    
    var path: String { 
        switch self {
        case .ranking(let teamId):
            return "/v1/teams/\(teamId)/pins/ranking"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .ranking:
            return .requestPlain
        }
    }
}

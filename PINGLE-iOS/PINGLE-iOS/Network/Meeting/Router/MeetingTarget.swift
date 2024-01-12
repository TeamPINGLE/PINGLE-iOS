//
//  MeetingTarget.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/12/24.
//

import Foundation

import Alamofire

enum MeetingTarget {
    case searchPlace(_ queryDTO: SearchPlaceRequestQueryDTO)

}

extension MeetingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .searchPlace:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .searchPlace:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchPlace:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchPlace(let location):
            return "/location"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchPlace(let queryDTO):
            return .requestQuery(queryDTO)
        }
    }
}

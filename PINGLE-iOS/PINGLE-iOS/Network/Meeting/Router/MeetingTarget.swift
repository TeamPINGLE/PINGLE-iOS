//
//  MeetingTarget.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/12/24.
//

import Foundation

import Alamofire

enum MeetingTarget {
    case makeMeeting(_ bodyDTO: MakeMeetingRequestBodyDTO)
    case searchPlace(_ queryDTO: SearchPlaceRequestQueryDTO)
}

extension MeetingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .makeMeeting:
            return .authorization
        case .searchPlace:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .makeMeeting:
            return .teamId
        case .searchPlace:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .makeMeeting:
            return .post
        case .searchPlace:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .makeMeeting:
            return "/meetings"
        case .searchPlace(let location):
            return "/location"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .makeMeeting(let bodyDTO):
            return .requestWithBody(bodyDTO)
        case .searchPlace(let queryDTO):
            return .requestQuery(queryDTO)
        }
    }
}
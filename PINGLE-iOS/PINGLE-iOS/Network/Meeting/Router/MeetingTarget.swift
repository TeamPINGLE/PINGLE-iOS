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
}

extension MeetingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .makeMeeting:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .makeMeeting:
            return .teamId
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .makeMeeting:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .makeMeeting:
            return "/meetings"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .makeMeeting(let bodyDTO):
            return .requestWithBody(bodyDTO)
        }
    }
}

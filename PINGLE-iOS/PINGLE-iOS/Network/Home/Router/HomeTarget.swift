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
    case pinDetail(_ teamId: Int, _ pinId: Int)
    case meetingJoin(_ meetingId: Int)
    case meetingCancel(_ meetingId: Int)
}

extension HomeTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .pinList:
            return .authorization
        case .pinDetail:
            return .authorization
        case .meetingJoin:
            return .authorization
        case .meetingCancel:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .pinList:
            return .hasToken
        case .pinDetail:
            return .hasToken
        case .meetingJoin:
            return .hasToken
        case .meetingCancel:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .pinList:
            return .get
        case .pinDetail:
            return .get
        case .meetingJoin:
            return .post
        case .meetingCancel:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .pinList(let teamId):
            return "/teams/\(teamId)/pins"
        case .pinDetail(let teamId, let pinId):
            return "/teams/\(teamId)/pins/\(pinId)/meetings"
        case .meetingJoin(let meetingId):
            return "/meetings/\(meetingId)/join"
        case .meetingCancel(let meetingId):
            return "/meetings/\(meetingId)/cancel"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .pinList:
            return .requestPlain
        case .pinDetail:
            return .requestPlain
        case .meetingJoin:
            return .requestPlain
        case .meetingCancel:
            return .requestPlain
        }
    }
}

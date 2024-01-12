//
//  OnboardingTarget.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/9/24.
//

import Foundation

import Alamofire

enum OnboardingTarget {
    case login(_ bodyDTO: LoginRequestBodyDTO)
    case userInfo
    case searchOrganization(_ queryDTO: SearchOrganizationRequestQueryDTO)
    case organizationDetail(_ teamId: Int)
    case enterInviteCode(_ teamId: Int, _ bodyDTO: EnterInviteCodeRequestBodyDTO)
    case postRefreshToken
}

extension OnboardingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .login:
            return .socialAuthorization
        case .userInfo:
            return .authorization
        case .searchOrganization:
            return .authorization
        case .organizationDetail:
            return .authorization
        case .enterInviteCode:
            return .authorization
        case .postRefreshToken:
            return .reAuthorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .login:
            return .providerToken
        case .userInfo:
            return .hasToken
        case .searchOrganization:
            return .hasToken
        case .organizationDetail:
            return .hasToken
        case .enterInviteCode:
            return .hasToken
        case .postRefreshToken:
            return .refreshToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .userInfo:
            return .get
        case .searchOrganization:
            return .get
        case .organizationDetail:
            return .get
        case .enterInviteCode:
            return .post
        case .postRefreshToken:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .userInfo:
            return "/users/me"
        case .searchOrganization:
            return "/teams"
        case .organizationDetail(let teamId):
            return "/teams/\(teamId)"
        case .enterInviteCode(let teamId, _):
            return "/teams/\(teamId)/register"
        case .postRefreshToken:
            return "/auth/reissue"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .login(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .userInfo:
            return .requestPlain
        case .searchOrganization(let queryDTO):
            return .requestQuery(queryDTO)
        case .organizationDetail:
            return .requestPlain
        case .enterInviteCode(_, let bodyDTO):
            return .requestWithBody(bodyDTO)
        case .postRefreshToken:
            return .requestPlain
        }
    }
}

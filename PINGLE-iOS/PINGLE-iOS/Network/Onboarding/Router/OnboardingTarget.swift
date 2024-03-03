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
    case checkName(_ parameterDTO: CheckNameRequestParameterDTO)
    case keyword
    case makeTeams(_ makeTeamsRequestBodyDTO: MakeTeamsRequestBodyDTO)
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
        case .checkName:
            return .authorization
        case .keyword:
            return .authorization
        case .makeTeams:
            return .authorization
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
        case .checkName:
            return .hasToken
        case .keyword:
            return .hasToken
        case .makeTeams:
            return .hasToken
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
        case .checkName:
            return .get
        case .keyword:
            return .get
        case .makeTeams:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/v1/auth/login"
        case .userInfo:
            return "/v1/users/me"
        case .searchOrganization:
            return "/v1/teams"
        case .organizationDetail(let teamId):
            return "/v1/teams/\(teamId)"
        case .enterInviteCode(let teamId, _):
            return "/v1/teams/\(teamId)/register"
        case .postRefreshToken:
            return "/v1/auth/reissue"
        case .checkName:
            return "/v1/teams/check-name"
        case .keyword:
            return "/v1/teams/keywords"
        case .makeTeams:
            return "/v1/teams"
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
        case .checkName(let parameterDTO):
            return .requestQuery(parameterDTO)
        case .keyword:
            return .requestPlain
        case .makeTeams(let bodyDTO):
            return .requestWithBody(bodyDTO)
        }
    }
}

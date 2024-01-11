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
        }
    }
}

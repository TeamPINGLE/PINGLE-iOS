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
}

extension OnboardingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .login:
            return .socialAuthorization
        case .userInfo:
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .login:
            return .providerToken
        case .userInfo:
            return .hasToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .userInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .userInfo:
            return "/users/me"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .login(bodyDTO):
            return .requestWithBody(bodyDTO)
        case .userInfo:
            return .requestPlain
        }
    }
}

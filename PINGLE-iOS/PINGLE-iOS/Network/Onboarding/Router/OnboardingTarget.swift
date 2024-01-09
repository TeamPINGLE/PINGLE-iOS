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
}

extension OnboardingTarget: TargetType {
    var authorization: Authorization {
        switch self {
        case .login(_):
            return .authorization
        }
    }
    
    var headerType: HTTPHeaderType {
        switch self {
        case .login(_):
            return .providerToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/auth/login"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case let .login(bodyDTO):
            return .requestWithBody(bodyDTO)
        }
    }
}

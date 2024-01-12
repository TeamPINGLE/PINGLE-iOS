//
//  HTTPHeaderFieldKey.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

enum HTTPHeaderFieldKey: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case accessToken = "accessToken"
    case refreshtoken = "refreshtoken"
    case providerToken = "X-Provider-Token"
    case teamId = "X-Team-Id"
}

enum HTTPHeaderFieldValue: String {
    case json = "Application/json"
    case accessToken
}

enum HTTPHeaderType {
    case plain
    case providerToken
    case hasToken
    case refreshToken
    case teamId
}

@frozen
enum Authorization {
    case authorization
    case unauthorization
    case socialAuthorization
    case reAuthorization
}

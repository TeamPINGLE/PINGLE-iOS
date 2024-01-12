//
//  TargetType.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var headerType: HTTPHeaderType { get }
    var authorization: Authorization { get }
}

extension TargetType {
    var baseURL: String {
        return Config.baseURL
    }
    var headers: [String: String]? {
        switch headerType {
        case .plain:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue
            ]
        case .hasToken:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderFieldKey.accessToken.rawValue: "Bearer \(KeychainHandler.shared.accessToken)",
                HTTPHeaderFieldKey.refreshtoken.rawValue: "Bearer \(KeychainHandler.shared.refreshToken)"
            ]
        case .refreshToken:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderFieldKey.xAccessAuth.rawValue: "Bearer \(KeychainHandler.shared.accessToken)",
                HTTPHeaderFieldKey.xRefreshAuth.rawValue: "Bearer \(KeychainHandler.shared.refreshToken)"
            ]
            
        case .providerToken:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderFieldKey.providerToken.rawValue: KeychainHandler.shared.providerToken
            ]
        case .teamId:
            return [
                HTTPHeaderFieldKey.contentType.rawValue: HTTPHeaderFieldValue.json.rawValue,
                HTTPHeaderFieldKey.teamId.rawValue: "\(KeychainHandler.shared.userGroup[0].id)"
            ]
        }
    }
}
extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        let accessToken = KeychainHandler.shared.accessToken
        var urlRequest = try URLRequest(
            url: url.appendingPathComponent(path),
            method: method
        )
        
        switch authorization {
        case .authorization:
            urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: HTTPHeaderFieldKey.authentication.rawValue)
        case .unauthorization:
            break
        case .socialAuthorization:
            urlRequest.setValue(KeychainHandler.shared.providerToken, forHTTPHeaderField: HTTPHeaderFieldKey.providerToken.rawValue)
        }
        
        switch headerType {
        case .plain:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
        case .hasToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
            urlRequest.setValue(KeychainHandler.shared.accessToken, forHTTPHeaderField: HTTPHeaderFieldKey.accessToken.rawValue)
            urlRequest.setValue(KeychainHandler.shared.refreshToken, forHTTPHeaderField: HTTPHeaderFieldKey.refreshtoken.rawValue)
        case.refreshToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
            urlRequest.setValue("Bearer \(KeychainHandler.shared.accessToken)", forHTTPHeaderField: HTTPHeaderFieldKey.xAccessAuth.rawValue)
            urlRequest.setValue("Bearer \(KeychainHandler.shared.refreshToken)", forHTTPHeaderField: HTTPHeaderFieldKey.xRefreshAuth.rawValue)
        case .providerToken:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
            urlRequest.setValue(KeychainHandler.shared.providerToken, forHTTPHeaderField: HTTPHeaderFieldKey.providerToken.rawValue)
        case .teamId:
            urlRequest.setValue(HTTPHeaderFieldValue.json.rawValue, forHTTPHeaderField: HTTPHeaderFieldKey.contentType.rawValue)
            urlRequest.setValue("\(KeychainHandler.shared.userGroup[0].id)", forHTTPHeaderField: HTTPHeaderFieldKey.teamId.rawValue)
        }
        
        switch parameters {
        case .requestWithBody(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        case .requestQuery(let request):
            let params = request?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .requestQueryWithBody(let queryRequest, let bodyRequest):
            let params = queryRequest?.toDictionary()
            let queryParams = params?.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            var components = URLComponents(
                string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
            
            let bodyParams = bodyRequest?.toDictionary() ?? [:]
            
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
            
        case .requestPlain:
            break
        }
        return urlRequest
    }
}

@frozen
enum RequestParams {
    case requestPlain
    case requestWithBody(_ paramter: Encodable?)
    case requestQuery(_ parameter: Encodable?)
    case requestQueryWithBody(_ queryParameter: Encodable?, bodyParameter: Encodable?)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any]
        else { return [:] }
        
        return dictionaryData
    }
}

//
//  PINGLERequestInterceptor.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/12/24.
//

import UIKit

import Alamofire

final class PINGLERequestInterceptor: RequestInterceptor {
    
    private let maxRetryCount: Int = 3
    var isrefreshed = false
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("✋interceptor adapt 작동")
        /// request 될 때마다 실행됨
        let accessToken = KeychainHandler.shared.accessToken
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("✋✋ interceptor 작동")
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        if request.retryCount < maxRetryCount {
            switch response.statusCode {
            case 500: /// 서버 내부 오류
                if request.retryCount < maxRetryCount {
                    completion(.retry)
                } else {
                    // 서버 점검 중 입니다. 잠시 후 다시 실행해주세요 경고화면 출력추가해야함.
                    completion(.doNotRetry)
                }
            case 401: // unauthorized
                refreshToken { isSuccess in
                    if isSuccess {
                        completion(.retry)
                    } else {
                        completion(.doNotRetry)
                    }
                }
            default:
                completion(.doNotRetry)
            }
        } else {
            // 네트워크 에러입니다. 잠시 후 다시 실행해주세요 경고화면 출력추가해야함. + 로그아웃 시키겠습니다.
            completion(.doNotRetry)
            self.logout()
        }
        
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("토큰 재발급 시작")
        NetworkService.shared.onboardingService.postRefreshToken() { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let data):
                if data.code == 200 {
                    /// 토큰 재발급에 성공하여 다시 저장.
                    guard let data = data.data else { return }
                    print("리프레쉬 토큰을 사용하여 토큰을 재발행하여 저장했습니다. ✅")
                    KeychainHandler.shared.refreshToken = data.refreshToken
                    KeychainHandler.shared.accessToken = data.accessToken
                    self.isrefreshed = true
                    completion(true)
                    return
                }
            case .failure:
                self.logout()
            default:
                completion(false)
                /// 재발행에 실패하여 로그아웃 처리.
            }
        }
    }
    
    func logout() {
        KeychainHandler.shared.logout()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }
}

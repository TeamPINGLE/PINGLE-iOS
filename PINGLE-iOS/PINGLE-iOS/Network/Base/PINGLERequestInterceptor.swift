//
//  PINGLERequestInterceptor.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/12/24.
//

import UIKit

import Alamofire

final class PINGLERequestInterceptor: RequestInterceptor {
    
    private var isRefreshingToken = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
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
        
        switch response.statusCode {
        case 401:
            requestsToRetry.append(completion)
            if !isRefreshingToken {
                isRefreshingToken = true
                refreshToken { [weak self] isSuccess in
                    guard let self = self else { return }
                    
                    self.isRefreshingToken = false
                    self.requestsToRetry.forEach { $0(isSuccess ? .retry : .doNotRetry) }
                    self.requestsToRetry.removeAll()
                }
            }
        default:
            completion(.doNotRetry)
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
                    completion(true)
                    return
                } else if data.code == 404 {
                    print("이미 탈퇴한 사용자로 찾을 수 없습니다.❌")
                    self.logout()
                }
            case .failure:
                self.logout()
            default:
                completion(false)
                self.logout()
            }
        }
    }
    
    func logout() {
        /// 토큰 초기화 이후 로그인 화면 이동
        KeychainHandler.shared.logout()
        DispatchQueue.main.async {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
    }
}

//
//  NetworkManager.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/10/24.
//

import Foundation

import Alamofire

class NetworkManager {
    
    func getUserInfo() {
        NetworkService.shared.onboardingService.userInfo { response in
            switch response {
            case .success(let data):
                guard let data = data.data else { return }
                KeychainHandler.shared.userGroup = data.groups
            default:
                print("getUserInfo error")
            }
        }
    }
}

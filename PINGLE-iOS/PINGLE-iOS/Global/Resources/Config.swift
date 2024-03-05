//
//  Config.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/1/24.
//

import Foundation

enum Config {
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let naverMapClientID = "NAVER_MAP_CLIENT_ID"
            static let amplitudeKey = "AMPLITUDE_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let naverMapClientID: String = {
        guard let key = Config.infoDictionary[Keys.Plist.naverMapClientID] as? String else {
            fatalError("metaAppID is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let amplitudeKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.amplitudeKey] as? String else {
            fatalError("metaAppID is not set in plist for this configuration.")
        }
        return key
    }()
}

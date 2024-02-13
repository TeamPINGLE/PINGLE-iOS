//
//  KeychainHandler.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/9/24.
//

import Foundation

import SwiftKeychainWrapper

struct Credentials {
    var tokenName: String
    var tokenContent: String
}

struct KeychainHandler {
    static var shared = KeychainHandler()
    
    private let keychain = KeychainWrapper(serviceName: "PINGLE", accessGroup: "com.PINGLE.iOS.keychainGroup")
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    private let providerTokenKey = "providerToken"
    private let authorizationCodeKey = "authorizationCode"
    private let userIDKey = "userID"
    private let userNameKey = "userName"
    private let userGroupKey = "userGroup"
    
    var accessToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: accessTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    var refreshToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: refreshTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
    
    var providerToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: providerTokenKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: providerTokenKey)
        }
    }
    
    var authorizationCode: String {
        get {
            return KeychainWrapper.standard.string(forKey: authorizationCodeKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: authorizationCodeKey)
        }
    }
    
    var userID: String {
        get {
            return KeychainWrapper.standard.string(forKey: userIDKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: userIDKey)
        }
    }
    
    var userName: String {
        get {
            return KeychainWrapper.standard.string(forKey: userNameKey) ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: userNameKey)
        }
    }
    
    var userGroup: [UserGroup] {
        get {
            return loadUserGroup()
        }
        set {
            saveUserGroup(newValue)
        }
    }
    
    mutating func logout() {
        accessToken = ""
        refreshToken = ""
        userGroup = []
        KeychainWrapper.standard.removeObject(forKey: userIDKey)
        KeychainWrapper.standard.removeObject(forKey: accessTokenKey)
        KeychainWrapper.standard.removeObject(forKey: refreshTokenKey)
        UserDefaults.standard.removeObject(forKey: userGroupKey)
    }
    
    mutating func deleteID() {
        accessToken = ""
        refreshToken = ""
        providerToken = ""
        authorizationCode = ""
        
        userGroup = []
        KeychainWrapper.standard.removeObject(forKey: userIDKey)
        KeychainWrapper.standard.removeObject(forKey: accessTokenKey)
        KeychainWrapper.standard.removeObject(forKey: refreshTokenKey)
        KeychainWrapper.standard.removeObject(forKey: providerTokenKey)
        KeychainWrapper.standard.removeObject(forKey: authorizationCodeKey)
        UserDefaults.standard.removeObject(forKey: userGroupKey)
    }
    
    func saveUserGroup(_ userGroups: [UserGroup]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userGroups) {
            UserDefaults.standard.set(encoded, forKey: "userGroup")
        }
    }

    func loadUserGroup() -> [UserGroup] {
        if let data = UserDefaults.standard.data(forKey: "userGroup") {
            let decoder = JSONDecoder()
            if let userGroups = try? decoder.decode([UserGroup].self, from: data) {
                return userGroups
            }
        }
        return []
    }
}

//
//  AppStoreCheck.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/19/24.
//

import UIKit

class AppStoreCheck {
    
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appStoreOpenUrlString = "itms-apps://itunes.apple.com/app/apple-store/6475423894"
    
    /// 앱 스토어 최신 정보 확인
    func latestVersion(completion: @escaping (String?) -> Void) {
        let appleID = "6475423894"
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appleID)&country=kr") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results[0]["version"] as? String else {
                completion(nil)
                return
            }
            
            completion(appStoreVersion)
        }.resume()
    }
    
    /// 앱 스토어로 이동
    func openAppStore() {
        guard let url = URL(string: AppStoreCheck.appStoreOpenUrlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

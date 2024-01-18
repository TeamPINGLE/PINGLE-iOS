//
//  AppStoreCheck.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/19/24.
//

import UIKit

class AppStoreCheck {
    
    static let shared = AppStoreCheck()
    
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
                  let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                print("Error parsing JSON data")
                completion(nil)
                return
            }

            print("JSON Data: \(json)")

            guard let results = json["results"] as? [[String: Any]], results.count > 0,
                  let appStoreVersion = results[0]["version"] as? String else {
                print("Error extracting version from JSON data")
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
    
    func checkAndUpdateIfNeeded(completion: @escaping (Bool) -> Void) {
        self.latestVersion { marketingVersion in
            DispatchQueue.main.async {
                guard let marketingVersion = marketingVersion else {
                    print("앱스토어 버전을 찾지 못했습니다.")
                    completion(true)
                    return
                }
                let currentProjectVersion = AppStoreCheck.appVersion ?? ""
                let splitMarketingVersion = marketingVersion.split(separator: ".").compactMap { Int($0) }
                let splitCurrentProjectVersion = currentProjectVersion.split(separator: ".").compactMap { Int($0) }
                
                print("현재 프로젝트 버전: \(currentProjectVersion)")
                print("앱스토어 버전: \(marketingVersion)")
                
                if splitCurrentProjectVersion.count > 0 && splitMarketingVersion.count > 0 {
                    if splitCurrentProjectVersion[0] < splitMarketingVersion[0] {
                        completion(false)
                    } else if splitCurrentProjectVersion[0] == splitMarketingVersion[0] && splitCurrentProjectVersion[1] < splitMarketingVersion[1] {
                        completion(false)
                    } else {
                        print("현재 최신 버전입니다.")
                        completion(true)
                    }
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func showUpdateAlert() {
        guard let window = UIApplication.shared.windows.first, let rootViewController = window.rootViewController else {
            print("Error: Unable to get the window or root view controller.")
            return
        }
        
        let alert = UIAlertController(
            title: StringLiterals.Update.title,
            message: StringLiterals.Update.description,
            preferredStyle: .alert
        )
        
        let updateAction = UIAlertAction(title: StringLiterals.Update.button, style: .default) { _ in
            AppStoreCheck().openAppStore()
        }
        
        alert.addAction(updateAction)
        rootViewController.present(alert, animated: true, completion: nil)
    }
}

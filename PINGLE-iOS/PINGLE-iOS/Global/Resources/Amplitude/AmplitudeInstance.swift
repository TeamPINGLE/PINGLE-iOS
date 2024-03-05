//
//  AmplitudeInstance.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 3/5/24.
//

import Foundation
import AmplitudeSwift

/// userProperty 사용법
/// AmplitudeInstance.shared.identify(userProperties: ["해당하는 프로퍼티" : "값"])
///
/// ex)
/// AmplitudeInstance.shared.identify(userProperties: [AmplitudeUserProperty.authType : "apple"])
///
/// event 사용법
/// AmplitudeInstance.shared.track(eventType: "여기에 해당하는 이벤트", eventProperties: ["매개변수 이름1" : "매개변수 값1", "매개변수 이름2" : "매개변수 값2"])
///
/// ex) 이벤트만 있을 때
/// AmplitudeInstance.shared.track(eventType: .openApp)
///
/// ex) 이벤트와 매개변수 모두 있을 때
/// AmplitudeInstance.shared.track(eventType: .openApp,
///                         eventProperties: [AmplitudePropertyType.groupName : self.groupName,
///                                      AmplitudePropertyType.email : self.email,
///                                      AmplitudePropertyType.keyword : self.groupType])

public struct AmplitudeInstance {
    static public let shared = Amplitude(configuration: Configuration(apiKey: Config.amplitudeKey))
    
    private init() {}
}

public extension Amplitude {
    func track(eventType: AmplitudeEventType, eventProperties: [String: Any]? = nil) {
        let eventType: String = eventType.rawValue
        
        AmplitudeInstance.shared.track(eventType: eventType, eventProperties: eventProperties, options: nil)
    }
}

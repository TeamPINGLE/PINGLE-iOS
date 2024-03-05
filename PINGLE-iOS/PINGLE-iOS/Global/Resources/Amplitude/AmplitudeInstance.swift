//
//  AmplitudeInstance.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 3/5/24.
//

import Foundation
import AmplitudeSwift

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

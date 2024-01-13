//
//  MeetingManager.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/11/24.
//

import UIKit

class MeetingManager {
    static let shared = MeetingManager()
    
    private init() {}
    
    var category: String = ""
    var name: String = ""
    var date: Date = Date()
    var startAt: Date = Date()
    var endAt: Date = Date()
    var x: Double = 0.0
    var y: Double = 0.0
    var address: String = ""
    var roadAddress: String = " "
    var location: String = ""
    var maxParticipants: Int = 0
    var chatLink: String = ""

}

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
    
    var category: String?
    var name: String?
    var date: String?
    var startAt: String?
    var endAt: String?
    var x: Double?
    var y: Double?
    var address: String?
    var location: String?
    var maxParticipants: Int?
    var chatLink: String?

}

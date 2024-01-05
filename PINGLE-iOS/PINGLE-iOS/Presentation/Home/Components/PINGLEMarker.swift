//
//  PINGLEMarker.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 1/4/24.
//

import UIKit

import NMapsMap

class PINGLEMarker: NMFMarker {
    
    // MARK: - Variables
    // MARK: Property
    var id: Int = 0
    var meetingStatus: ChipStatus = .play
    var meetingString = "PLAY"
    
    // MARK: - Function
    // MARK: Custom Func
    func changeStringToStatus(string: String) {
        switch string {
        case "PLAY":
            meetingStatus = .play
            
        case "STUDY":
            meetingStatus = .study

        case "MULTI":
            meetingStatus = .multi

        case "OTHERS":
            meetingStatus = .others
            
        default:
            meetingStatus = .others
        }
    }    
}

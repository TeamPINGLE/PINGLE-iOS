//
//  CALayer+.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 1/4/24.
//

import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, frameHeight: CGFloat, framgeWidth: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: framgeWidth, height: width)
                
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frameHeight - width, width: framgeWidth, height: width)
                
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frameHeight)
                
            case UIRectEdge.right:
                border.frame = CGRect.init(x: framgeWidth - width, y: 0, width: width, height: frameHeight)
                
            default:
                break
                
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}

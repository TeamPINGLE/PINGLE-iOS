//
//  UIViewController+.swift
//  PINGLE-iOS
//
//  Created by 정채은 on 12/31/23.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var safeAreaHeight: CGFloat {
        let window = UIApplication.shared.windows[0]
        let safeTop = window.safeAreaInsets.top
        let safeBottom = window.safeAreaInsets.bottom
        let height = window.frame.height - (safeTop + safeBottom)
        return height
    }
}

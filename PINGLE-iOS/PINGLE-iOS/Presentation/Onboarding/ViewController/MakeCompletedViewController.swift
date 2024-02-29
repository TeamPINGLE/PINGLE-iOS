//
//  MakeCompletedViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/29/24.
//

import UIKit

import SnapKit
import Then

final class MakeCompletedViewController: BaseViewController {
    
    // MARK: Variables
    var organizationName: String?
    var inviteCode: String?
    
    // MARK: Property
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UI
    override func setStyle() {
        view.do {
            $0.backgroundColor = .grayscaleG11
        }
    }
    
    override func setLayout() {
        
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Target Function
    private func setTarget() {
        
    }
    
    // MARK: Objc Function
    
    
    // MARK: SetButton
    
    
    // MARK: SetOrganizationName
    
}

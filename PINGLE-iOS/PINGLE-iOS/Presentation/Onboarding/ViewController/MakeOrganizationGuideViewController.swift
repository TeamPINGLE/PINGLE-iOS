//
//  MakeGroupGuideViewController.swift
//  PINGLE-iOS
//
//  Created by 강민수 on 2/20/24.
//

import UIKit

import SnapKit
import Then

final class MakeOrganizationGuideViewController: BaseViewController {
    
    // MARK: Property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        view.backgroundColor = .red
    }
    
    // MARK: UI
    override func setStyle() {
        
    }
    
    override func setLayout() {
        
    }
    
    // MARK: Navigation Function
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

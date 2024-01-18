//
//  AddPingleViewController.swift
//  PINGLE-iOS
//
//  Created by 방민지 on 1/18/24.
//

import UIKit

class AddPingleViewController: BaseViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

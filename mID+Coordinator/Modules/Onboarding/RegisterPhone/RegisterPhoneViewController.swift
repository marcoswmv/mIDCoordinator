//
//  RegisterPhoneViewController.swift
//  mID+Coordinator
//
//  Created by Mathias Nonohay on 15/05/2024.
//

import UIKit

extension RegisterPhoneViewController {
    enum Action {
        case goBack
        case goForward
    }
}

final class RegisterPhoneViewController: RootViewController {
    
    var performAction: ((RegisterPhoneViewController.Action) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(self)"
    }
    
    @IBAction func didTouchRegister(_ sender: Any) {
        print("Register did begin")
        performAction?(.goBack)
    }
    
    @IBAction func didTouchFoward(_ sender: Any) {
        performAction?(.goForward)
    }
}

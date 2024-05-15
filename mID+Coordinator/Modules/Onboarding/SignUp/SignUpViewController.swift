//
//  SignUpViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 05/04/2024.
//

import UIKit

extension SignUpViewController {
    enum Action {
        case didCompleteSignUp
        case navigateToRegisterPhone
    }
}

final class SignUpViewController: RootViewController {

    var performAction: ((SignUpViewController.Action) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction 
    private func didPressSignUp(_ sender: Any) {
        performAction?(.navigateToRegisterPhone)
    }
}

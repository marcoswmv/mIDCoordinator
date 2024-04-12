//
//  AuthenticationMainViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

extension AuthenticationMainViewController {
    enum Action {
    }
}

final class AuthenticationMainViewController: RootViewController {
    
    var performAction: ((AuthenticationMainViewController.Action) -> Void)?
    
    deinit {
        print("\(self) deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Autenticar"
    }
}

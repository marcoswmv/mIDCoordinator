//
//  SignatureMainViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

extension SignatureMainViewController {
    enum Action {
    }
}

final class SignatureMainViewController: RootViewController {
    
    var performAction: ((SignatureMainViewController.Action) -> Void)?
    
    deinit {
        print("\(self) deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Assinar"
    }
}

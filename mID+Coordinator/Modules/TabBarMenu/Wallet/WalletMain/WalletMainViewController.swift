//
//  WalletMainViewController.swift
//  Coordinators
//
//  Created by Marcos Vicente on 02/04/2024.
//

import UIKit

extension WalletMainViewController {
    enum Action {
        case addDocument
    }
}

final class WalletMainViewController: RootViewController {
    
    var performAction: ((WalletMainViewController.Action) -> Void)?
    
    deinit {
        print("\(self) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Carteira"
    }
    
    @IBAction 
    private func didPressAddDocument(_ sender: Any) {
        performAction?(.addDocument)
    }
}

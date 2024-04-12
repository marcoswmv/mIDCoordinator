//
//  ActivityMainViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 03/04/2024.
//

import UIKit

extension ActivityMainViewController {
    enum Action {
    }
}

final class ActivityMainViewController: RootViewController {
    
    var performAction: ((ActivityMainViewController.Action) -> Void)?
    
    deinit {
        print("\(self) deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Atividade"
    }
}


//
//  MoreMainViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 09/04/2024.
//

import UIKit

extension MoreMainViewController {
    enum Action {
    }
}

final class MoreMainViewController: RootViewController {
    
    var performAction: ((MoreMainViewController.Action) -> Void)?
    
    deinit {
        print("\(self) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mais"
    }
}

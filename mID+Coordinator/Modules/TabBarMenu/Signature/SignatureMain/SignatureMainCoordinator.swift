//
//  SignatureMainCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

final class SignatureMainCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .signature }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let viewController: SignatureMainViewController = .instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

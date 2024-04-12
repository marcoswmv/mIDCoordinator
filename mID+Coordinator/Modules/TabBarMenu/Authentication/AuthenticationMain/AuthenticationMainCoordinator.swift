//
//  AuthenticationMainCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

final class AuthenticationMainCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .authentication }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let viewController: AuthenticationMainViewController = .instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

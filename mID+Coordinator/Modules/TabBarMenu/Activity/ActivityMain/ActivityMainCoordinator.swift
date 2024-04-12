//
//  ActivityMainCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

final class ActivityMainCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .activity }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let viewController: ActivityMainViewController = .instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

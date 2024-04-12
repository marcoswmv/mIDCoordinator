//
//  SplashCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 04/04/2024.
//

import UIKit

final class SplashCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .app }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let viewController: SplashViewController = .instantiate()
        viewController.coordinator = self
        viewController.performAction = { [weak self] action in
            guard let self else { return }
            switch action {
            case .didFinishAnimation(let step):
                // TODO: Possible place to call .getRouterFromStep and route to where needed
                finish(with: step)
            }
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

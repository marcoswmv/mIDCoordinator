//
//  SignUpCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 05/04/2024.
//

import UIKit

final class SignUpCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .onboarding }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let viewController: SignUpViewController = .instantiate()
        viewController.coordinator = self
        viewController.performAction = { [weak self] action in
            guard let self else { return }
            switch action {
            case .didCompleteSignUp:
                // TODO: Possible place to call .getRouterFromStep and route to where needed
                finish(with: nil)
            case .navigateToRegisterPhone:
                routingDelegate?.pushCoordinator(next: OnboardingStep.registerPhone)
            }
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}

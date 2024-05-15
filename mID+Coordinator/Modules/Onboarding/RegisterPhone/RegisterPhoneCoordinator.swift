//
//  RegisterPhoneCoordinator.swift
//  mID+Coordinator
//
//  Created by Mathias Nonohay on 15/05/2024.
//

import UIKit

final class RegisterPhoneCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .onboarding }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let registerPhoneVC = RegisterPhoneViewController.instantiate()
        registerPhoneVC.coordinator = self
        registerPhoneVC.performAction = { [weak self] action in
            guard let self else { return }
            switch action {
            case .goBack:
                routingDelegate?.popCoordinator(self)
            case .goForward:
                finish(with: OnboardingStep.completed)
            }
            
        }
        navigationController.pushViewController(registerPhoneVC, animated: true)
    }
}

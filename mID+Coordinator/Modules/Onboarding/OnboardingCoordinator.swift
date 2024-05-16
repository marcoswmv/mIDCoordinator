//
//  OnboardingCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

final class OnboardingCoordinator: RootCoordinator {

    override var flow: CoordinatorFlow { .onboarding }
    
    convenience init(_ navigationController: UINavigationController, step: OnboardingStep) {
        self.init(navigationController)
        self.step = step
    }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        navigationController.delegate = self
        setupRootCoordinatorControllerDelegates(navigationBarDelegate: self)
        configureCoordinator(for: OnboardingStep.signUp)
    }
    
    private func configureCoordinator(for step: OnboardingStep = .completed) {
        var coordinator: RootCoordinator?
        
        switch step {
        case .signUp:
            coordinator = SignUpCoordinator(navigationController)
        case .completed:
            routingDelegate?.childCoordinatorDidFinish(self, with: nil)
        case .registerPhone:
            coordinator = RegisterPhoneCoordinator(navigationController)
        }
        
        if let coordinator {
            coordinator.routingDelegate = self
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
}

extension OnboardingCoordinator: CoordinatorRoutingDelegate {
    func pushCoordinator(next step: any StepProtocol) {
        guard let step = step as? OnboardingStep else { return }
        configureCoordinator(for: step)
    }
    
    func popCoordinator(_ childCoordinator: RootCoordinator) {
        popChildCoordinator(childCoordinator)
        navigationController.popViewController(animated: true)
    }
    
    func childCoordinatorDidFinish(_ childCoordinator: RootCoordinator, with step: StepProtocol?) {
        guard let step = step as? OnboardingStep else { return }
        setChildCoordinators(childCoordinators.filter({ $0.flow != childCoordinator.flow })) // This is popping current child cordinator
        if !navigationController.viewControllers.isEmpty {
            navigationController.viewControllers.removeAll()
        }
        
        switch step {
        case .signUp:
            break;
        case .completed:
            configureCoordinator(for: .completed)
        case .registerPhone:
            configureCoordinator(for: .signUp)
        }
    }
}

extension OnboardingCoordinator: CoordinatorNavigationBarDelegate {
    func didShowViewController(on navigationController: UINavigationController, viewController: UIViewController, animated: Bool) {
        /// Make sure the view controller is popping
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        /// Check whether our view controller array already contains that view controller.
        /// If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        /// If not then we remove the current child coordinator
        guard let fromViewControllerCoordinator = (fromViewController as? RootViewController)?.coordinator else { return }
        removeChildCoordinator(fromViewControllerCoordinator)
    }
}

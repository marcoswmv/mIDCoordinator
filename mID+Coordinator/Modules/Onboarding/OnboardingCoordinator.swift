//
//  OnboardingCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

final class OnboardingCoordinator: RootCoordinator {

    override var flow: CoordinatorFlow { .onboarding }
    private var step: OnboardingStep
    
    convenience init(_ navigationController: UINavigationController, step: OnboardingStep) {
        self.init(navigationController)
        self.step = step
    }
    
    required init(_ navigationController: UINavigationController) {
        self.step = .signUp
        super.init(navigationController)
    }
    
    override func start() {
        configureCoordinator(for: self.step)
    }
    
    private func configureCoordinator(for step: OnboardingStep = .completed) {
        var coordinator: RootCoordinator?
        
        switch step {
        case .signUp:
            coordinator = SignUpCoordinator(navigationController)
        case .completed:
            routingDelegate?.childCoordinatorDidFinish(self, with: nil)
        }
        
        if let coordinator {
            coordinator.routingDelegate = self
//            setupControllerDelegates(navigationBarDelegate: self)
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
}

extension OnboardingCoordinator: CoordinatorRoutingDelegate {
    func childCoordinatorDidFinish(_ childCoordinator: RootCoordinator, with step: StepProtocol?) {
        setChildCoordinators(childCoordinators.filter({ $0.flow != childCoordinator.flow }))
        if !navigationController.viewControllers.isEmpty {
            navigationController.viewControllers.removeAll()
        }
        configureCoordinator()
    }
}

//extension OnboardingCoordinator: CoordinatorNavigationBarDelegate {
//    func didShowViewController(on navigationController: UINavigationController, viewController: UIViewController, animated: Bool) {
//        /// Make sure the view controller is popping
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//        
//        /// Check whether our view controller array already contains that view controller.
//        /// If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//        
//        /// If not then we remove the current child coordinator
//        deallocateChildCoordinator(self, with: fromViewController)
//    }
//    
//    private func deallocateChildCoordinator(_ coordinator: Coordinator, with viewController: UIViewController) {
//        /// Condition just for example purposes. It won't work because there won't be a Back button in this View Controller's nav bar
//        if viewController is SignUpViewController {
//            removeChildCoordinator(coordinator)
//        }
//    }
//}

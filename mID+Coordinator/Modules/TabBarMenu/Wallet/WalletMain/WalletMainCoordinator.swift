//
//  WalletMainCoordinator.swift
//  Coordinators
//
//  Created by Marcos Vicente on 02/04/2024.
//

import UIKit

final class WalletMainCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .wallet }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let viewController: WalletMainViewController = .instantiate()
        viewController.coordinator = self
        viewController.performAction = { [weak self] action in
            guard let self else { return }
            switch action {
            case .addDocument:
                configureCoordinator(for: .addDocument)
            }
        }
        setupRootCoordinatorControllerDelegates(navigationBarDelegate: self)
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func configureCoordinator(for step: WalletStep = .completed) {
        var coordinator: RootCoordinator?
        
        switch step {
        case .addDocument:
            coordinator = AddDocumentCoordinator(navigationController)
        case .activity:
            break
        case .completed:
            start()
        case .resetApp:
            // Deallocating every coordinator (and viewControllers) up to AppCoordinator and from the latter show Splash
            routingDelegate?.childCoordinatorDidFinish(self, with: nil)
        }
        
        if let coordinator {
            coordinator.routingDelegate = self
            coordinator.tabCoordinatorDelegate = tabCoordinatorDelegate
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
}

extension WalletMainCoordinator: CoordinatorRoutingDelegate {
    func popCoordinator(_ childCoordinator: RootCoordinator) {
        debugPrint("\(self) \(#function)")
    }
    
    func pushCoordinator(next step: any StepProtocol) {
        debugPrint("\(self) \(#function)")
    }
    
    func childCoordinatorDidFinish(_ childCoordinator: RootCoordinator, with step: StepProtocol?) {
        setChildCoordinators(childCoordinators.filter({ $0.flow != childCoordinator.flow }))
        
        if !navigationController.viewControllers.isEmpty {
            navigationController.viewControllers.removeAll()
        }
        
        if let walletStep = step as? WalletStep {
            configureCoordinator(for: walletStep)
        }
    }
}

extension WalletMainCoordinator: CoordinatorNavigationBarDelegate {
    func didShowViewController(on navigationController: UINavigationController, viewController: UIViewController, animated: Bool) {
        /// 1 - Make sure the view controller is popping
        /// 2 - Check whether our viewController is in viewControllers list.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), /*1*/
              !navigationController.viewControllers.contains(fromViewController) /*2*/ else {
            /// If fromViewController is in viewControllers list then it means we're pushing another ViewController to the top
            return
        }
        
        /// If not, it means we're popping our fromViewController
        /// so we can proceed and remove it's coordinator
        if let poppedViewController = fromViewController as? Coordinated,
           let coordinator = poppedViewController.coordinator {
            removeChildCoordinator(coordinator)
        }
    }
}

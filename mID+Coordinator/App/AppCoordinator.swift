//
//  AppCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 04/04/2024.
//

import UIKit

/// App coordinator is the only one coordinator which will exist during app's life cycle
final class AppCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .app }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    override func start() {
        configureCoordinator(for: .app)
    }
    
    private func configureCoordinator(for flow: CoordinatorFlow, in step: StepProtocol? = nil) {
        var coordinator: RootCoordinator?
        
        switch flow {
        case .app:
            coordinator = SplashCoordinator(navigationController)
        case .onboarding:
            if let onboardingStep = step as? OnboardingStep {
                coordinator = OnboardingCoordinator(navigationController, step: onboardingStep)
            }
        case .mainTab:
            coordinator = MainTabCoordinator(navigationController, step: step)
        case .wallet,
                .signature,
                .authentication,
                .activity,
                .more:
            break
        }
        
        if let coordinator {
            coordinator.routingDelegate = self
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
    
    private func getCoordinatorFlow(by step: StepProtocol?) -> CoordinatorFlow {
        switch step {
        case is OnboardingStep:
            return .onboarding
        case is WalletStep:
            return .mainTab
        default:
            return .app
        }
    }
}

extension AppCoordinator: CoordinatorRoutingDelegate {
    func popCoordinator(_ childCoordinator: RootCoordinator) {
        debugPrint("\(self) \(#function)")
    }
    
    func pushCoordinator(next step: any StepProtocol) {
        debugPrint("\(self) \(#function)")
    }
     
    // Splash in .app flow is a redirection point so it never calls this method.
    func childCoordinatorDidFinish(_ childCoordinator: RootCoordinator, with step: StepProtocol?) {
        setChildCoordinators(childCoordinators.filter({ $0.flow != childCoordinator.flow }))
        
        if !navigationController.viewControllers.isEmpty {
            navigationController.viewControllers.removeAll()
        }
        
        switch childCoordinator.flow {
        case .mainTab:
            configureCoordinator(for: .app)
            
        case .onboarding:
            configureCoordinator(for: .mainTab)
            
        case .app:
            let destinationFlow: CoordinatorFlow = getCoordinatorFlow(by: step)
            configureCoordinator(for: destinationFlow, in: step)
            
        case .wallet,
                .signature,
                .authentication,
                .activity,
                .more:
            break
        }
    }
}

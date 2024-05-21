//
//  CoordinatorDelegate.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024. testete //gitignoreline
//

import UIKit

/// Routing handled by the parent Coordinator
protocol CoordinatorRoutingDelegate: AnyObject {
    func childCoordinatorDidFinish(_ childCoordinator: RootCoordinator, with step: StepProtocol?)
    func popCoordinator(_ childCoordinator: RootCoordinator)
    func pushCoordinator(next step: StepProtocol)
}

// MARK: - UINavigationController ouput
/// Responsible for propagating up to the coordinator who inherits Coordinator object when UINavigationControllerDelegate triggers didShow
protocol CoordinatorNavigationBarDelegate: AnyObject {
    func didShowViewController(on navigationController: UINavigationController, viewController: UIViewController, animated: Bool)
}

// MARK: - TabBarController output and TabBarCoordinator routing
protocol CoordinatorTabBarDelegate: AnyObject {
    func didSelectViewController(on tabBarController: UITabBarController, viewController: UIViewController)
    func shouldSelectViewController(on tabBarController: UITabBarController, viewController: UIViewController)
}

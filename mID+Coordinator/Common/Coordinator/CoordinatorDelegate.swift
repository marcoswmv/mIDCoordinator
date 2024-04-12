//
//  CoordinatorDelegate.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

/// Routing handled by the parent Coordinator
protocol CoordinatorRoutingDelegate: AnyObject {
    func childCoordinatorDidFinish(_ childCoordinator: RootCoordinator, with step: StepProtocol?)
}

// MARK: - UINavigationController ouput
/// Responsible for propagating up to the coordinator who inherits Coordinator object when UINavigationControllerDelegate triggers didShow
protocol CoordinatorNavigationBarDelegate: AnyObject {
    func didShowViewController(on navigationController: UINavigationController, viewController: UIViewController, animated: Bool)
}

// MARK: - TabBarController output and TabBarCoordinator routing
protocol CoordinatorTabBarDelegate: AnyObject {
    func navigateTo(next tab: MainTabPage)
    func didSelectViewController(on tabBarController: UITabBarController, viewController: UIViewController)
}

//
//  RootCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import UIKit

class RootCoordinator: NSObject, CoordinatorProtocol {
    
    weak var routingDelegate: CoordinatorRoutingDelegate?
    weak var tabCoordinatorDelegate: MainTabCoordinatorDelegate?
    private weak var navigationBarDelegate: CoordinatorNavigationBarDelegate?
    private weak var tabBarDelegate: CoordinatorTabBarDelegate?
    var navigationController: UINavigationController
    var step: StepProtocol?
    /// Getter is public and setter is private. One should use public CRUD methods below to modify property
    private(set) var childCoordinators: [RootCoordinator] = [RootCoordinator]()
    var flow: CoordinatorFlow { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    public func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    public func setupRootCoordinatorControllerDelegates(navigationBarDelegate: CoordinatorNavigationBarDelegate? = nil,
                                                        tabBarDelegate: CoordinatorTabBarDelegate? = nil) {
        self.navigationBarDelegate = navigationBarDelegate
        self.tabBarDelegate = tabBarDelegate
    }
    
    public func finish(with step: StepProtocol?) {
        removeAllChildCoordinators() // Cleaning up Caller-Coordinator's child coordinators stack
        routingDelegate?.childCoordinatorDidFinish(self, with: step)
    }
    
    public func addChildCoordinator(_ coordinator: RootCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChildCoordinator(_ coordinator: RootCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
    
    @discardableResult
    public func popChildCoordinator(_ coordinator: RootCoordinator) -> RootCoordinator? {
//        if let index = childCoordinators.lastIndex(of: coordinator),
//           let lastChildCoordinator = childCoordinators.last,
//           let lastIndex = childCoordinators.lastIndex(of: lastChildCoordinator),
//           index == lastIndex {
//            return childCoordinators.remove(at: index)
//        }
        
        if coordinator == childCoordinators.last {
            return childCoordinators.popLast()
        }
        
        return nil
    }
    
    public func setChildCoordinators(_ coordinators: [RootCoordinator]) {
        childCoordinators = coordinators
    }
    
    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

// MARK: - Equatable Conformance
extension RootCoordinator {
    static func == (lhs: RootCoordinator, rhs: RootCoordinator) -> Bool {
        lhs === rhs
    }
}

// MARK: - UINavigationControllerDelegate
/// To handle coordinator dismissal on pop from back button
extension RootCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationBarDelegate?.didShowViewController(on: navigationController, viewController: viewController, animated: animated)
    }
}

// MARK: - UITabBarControllerDelegate
extension RootCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarDelegate?.didSelectViewController(on: tabBarController, viewController: viewController)
    }
}

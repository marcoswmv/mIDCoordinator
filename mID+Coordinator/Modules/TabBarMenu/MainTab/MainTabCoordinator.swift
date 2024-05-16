//
//  TabBarCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 05/04/2024.
//

import UIKit

protocol MainTabCoordinatorDelegate: AnyObject {
    func selectTab(_ tab: MainTabPage)
}

final class MainTabCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .mainTab }
    var tabBarController: UITabBarController
    
    convenience init(_ navigationController: UINavigationController, step: StepProtocol?) {
        self.init(navigationController)
        self.step = step
    }
    
    required init(_ navigationController: UINavigationController) {
        self.tabBarController = .init()
        super.init(navigationController)
    }
    
    override func start() {
        let pages: [MainTabPage] = MainTabPage.allCases
            .sorted(by: { $0.rawValue < $1.rawValue })
        let navigationControllers: [UINavigationController] = pages
            .map({ setNavigationControllerForTabBarItem(for: $0) })
        prepareTabBarController(with: navigationControllers)
    }
    
    private func setNavigationControllerForTabBarItem(for page: MainTabPage) -> UINavigationController {
        let navigationController = UINavigationController()
//        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.tabBarItem = UITabBarItem(title: page.title, image: nil, tag: page.rawValue)
        configureCoordinator(for: page, with: navigationController)
        
        return navigationController
    }
    
    private func configureCoordinator(for page: MainTabPage, with navigationController: UINavigationController) {
        var coordinator: RootCoordinator?
        
        switch page {
        case .wallet:
            coordinator = WalletMainCoordinator(navigationController)
        case .authentication:
            coordinator = AuthenticationMainCoordinator(navigationController)
        case .signature:
            coordinator = SignatureMainCoordinator(navigationController)
        case .activity:
            coordinator = ActivityMainCoordinator(navigationController)
        case .more:
            coordinator = MoreMainCoordinator(navigationController)
        }
        
        if let coordinator {
            coordinator.routingDelegate = self
            coordinator.tabCoordinatorDelegate = self
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
    
    private func prepareTabBarController(with controllers: [UIViewController]) {
//        tabBarController.delegate = self
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.selectedIndex = MainTabPage.wallet.rawValue
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .systemBlue
        
        let font: UIFont = UIFont(name: "Inter-Bold", size: 14)!
        UITabBarItem.appearance().setTitleTextAttributes([.font: font], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.font: font], for: .selected)
        
        navigationController.viewControllers = [tabBarController]
    }
    
    func currentPage() -> MainTabPage? { MainTabPage(index: tabBarController.selectedIndex) }
    
    func selectTab(at index: Int) {
        guard let page = MainTabPage(index: index) else { return }
        tabBarController.selectedIndex = page.rawValue
    }
}

extension MainTabCoordinator: MainTabCoordinatorDelegate {
    func selectTab(_ page: MainTabPage) {
        tabBarController.selectedIndex = page.rawValue
    }
}

extension MainTabCoordinator: CoordinatorRoutingDelegate {
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
        
        routingDelegate?.childCoordinatorDidFinish(self, with: step)
    }
}

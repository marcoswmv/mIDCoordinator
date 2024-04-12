//
//  MoreMainCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 09/04/2024.
//

import UIKit

final class MoreMainCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .more }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let moreVC = MoreMainViewController.instantiate()
        moreVC.performAction = { [weak self] action in
            guard let self else { return }
        }
        navigationController.pushViewController(moreVC, animated: true)
    }
}

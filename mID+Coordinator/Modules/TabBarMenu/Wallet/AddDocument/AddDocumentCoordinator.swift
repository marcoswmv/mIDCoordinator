//
//  AddDocumentCoordinator.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 09/04/2024.
//

import UIKit

final class AddDocumentCoordinator: RootCoordinator {
    
    override var flow: CoordinatorFlow { .wallet }
    
    required init(_ navigationController: UINavigationController) {
        super.init(navigationController)
    }
    
    override func start() {
        let addDocumentVC = AddDocumentViewController.instantiate()
        addDocumentVC.coordinator = self
        addDocumentVC.performAction = { [weak self] action in
            guard let self else { return }
            switch action {
            case .finish:
                finish(with: WalletStep.completed)
            }
        }
        navigationController.pushViewController(addDocumentVC, animated: true)
    }
}

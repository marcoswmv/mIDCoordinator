//
//  CoordinatorProtocol.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 04/04/2024.
//

import UIKit

/// NextEntryTypes to adapt on MulticertID project: .push, .pushAsFirst, .pushFromFirst, .pushStack, .dismiss, .popIfNeeded
/// .pushFromFirst: removes all Controllers in between first and last

// MARK: - Coordinator Protocol
protocol CoordinatorProtocol: AnyObject {
    var routingDelegate: CoordinatorRoutingDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var flow: CoordinatorFlow { get }
    
    func start()
    /// A place to put logic to finish the flow, to clean all children coordinators, and to notify the parent that this coordinator is ready to be deallocated
    func finish(with step: StepProtocol?)
    
    init(_ navigationController: UINavigationController)
}

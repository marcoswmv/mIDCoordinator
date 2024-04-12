//
//  WalletStep.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 05/04/2024.
//

import Foundation

enum WalletStep: StepProtocol {
    case addDocument
    case completed
    case resetApp
    
    var flow: CoordinatorFlow { .wallet }
}

//
//  CoordinatorFlow.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 08/04/2024.
//

import Foundation

/// Using this structure we can define what type of flow we can use in-app.
enum CoordinatorFlow {
//    MARK: - Main Coordinators
    /// There are only two possible flows:
    /// - Onboarding
    /// - Tabs
    /// - App: only responsible for showing splash
    case app // Splash
    case mainTab
    case onboarding
    
//    MARK: - (Only) Child Coordinators
    case wallet
    case signature
    case authentication
    case activity
    case more
}

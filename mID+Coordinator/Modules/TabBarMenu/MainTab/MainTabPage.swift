//
//  MainTabPage.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 05/04/2024.
//

import Foundation

enum MainTabPage: Int, CaseIterable {
    case wallet = 0
    case authentication = 1
    case signature = 2
    case activity = 3
    case more = 4
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .wallet
        case 1:
            self = .authentication
        case 2:
            self = .signature
        case 3:
            self = .activity
        case 4:
            self = .more
        default: 
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .wallet:
            return "Carteira"
        case .authentication:
            return "Autenticar"
        case .signature:
            return "Assinar"
        case .activity:
            return "Atividade"
        case .more:
            return "Mais"
        }
    }
    
    // Add tab icon value
    // Add tab icon selected / deselected color
    // etc
}

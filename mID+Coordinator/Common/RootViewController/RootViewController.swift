//
//  RootViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 10/04/2024.
//

import UIKit

class RootViewController: UIViewController, Storyboarded, Coordinated {
    weak var coordinator: RootCoordinator?
    
    deinit {
        print("\(self) deinit")
    }
}

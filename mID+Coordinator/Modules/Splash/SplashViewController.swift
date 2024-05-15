//
//  SplashViewController.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 03/04/2024.
//

import UIKit

extension SplashViewController {
    enum Action {
        case didFinishAnimation(step: StepProtocol)
    }
}

final class SplashViewController: RootViewController {
    
    var performAction: ((SplashViewController.Action) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make a call to checkAppState() on dedicated ViewModel/Presenter to dedicated Service/Manager
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Call on response handler of checkAppState()
            self.performAction?(.didFinishAnimation(step: OnboardingStep.signUp))
        }
    }
}

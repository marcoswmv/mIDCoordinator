//
//  OnboardingStep.swift
//  mID+Coordinator
//
//  Created by Marcos Vicente on 05/04/2024.
//

import Foundation

enum OnboardingStep: StepProtocol {
    case signUp
    case completed
    case registerPhone
    
    var flow: CoordinatorFlow { .onboarding }
}

//
//  appLogIn.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/26.
//

import Foundation
import LocalAuthentication

func authenticateUser() {
    print("authenticateUser called")
    
    let authenticationContext = LAContext()
    var error: NSError?
    
    if UserDefaults.standard.bool(forKey: "useFaceID") && authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        authenticationContext.evaluatePolicy( .deviceOwnerAuthenticationWithBiometrics, localizedReason: "FaceID for logging-in to wallet", reply: { (success, evalPolicyError) in
            if success {
                print("success")
            } else {
                print("fail")
            }
        }
        )}}


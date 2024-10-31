//
//  appLogIn.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/26.
//

import Foundation
import LocalAuthentication

func authenticateUser() {
        let authenticationContext = LAContext()
        var error: NSError?

        // Check if the device can evaluate the policy.
        if authenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error) {

            authenticationContext.evaluatePolicy( .deviceOwnerAuthentication, localizedReason: "Log-in to Wallet", reply: { (success, evalPolicyError) in

                if success {
                    authenticationContext.evaluatePolicy( .deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log-in to Wallet", reply: { (success, evalPolicyError) in

                        if success {
                            print("success")
                        } else {
                            print("error")
                        }
                    })
                } else {
                    print("error")
                }
            })

        } else {
            print("passcode not set")
        }
    }

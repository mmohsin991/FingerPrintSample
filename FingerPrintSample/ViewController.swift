

//
//  ViewController.swift
//  FingerPrintSample
//
//  Created by Mohsin on 26/11/2015.
//  Copyright © 2015 Mohsin. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func touchAuth(){
        if #available(iOS 8.0, *) {
            let authContex = LAContext()
            var error : NSError?
            if authContex.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
                
                // 3. Check the fingerprint
                authContex.evaluatePolicy(
                    .DeviceOwnerAuthenticationWithBiometrics,
                    localizedReason: "Only awesome people are allowed",
                    reply: { [unowned self] (success, error) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if( success ) {
                                
                                // Fingerprint recognized
                                // Go to view controller
                                let alert = UIAlertView(title: "Success", message: "You are the owner.", delegate: nil, cancelButtonTitle: "OK")
                                alert.show()
                            }else {
                                
                                // Check if there is an error
                                if let error = error {
                                    
                                    let alert = UIAlertView(title: "Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
                                    alert.show()
                                    
                                }
                                
                            }
                            
                        })
                        
                    })
            }
            else {
                let alert = UIAlertView(title: "Error", message: "Your device can,t have tounch sensor", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
        } else {
            // Fallback on earlier versions
        }

    }
    
    
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        if #available(iOS 9.0, *) {
            switch errorCode {
                
            case LAError.AppCancel.rawValue:
                message = "Authentication was cancelled by application"
                
            case LAError.AuthenticationFailed.rawValue:
                message = "The user failed to provide valid credentials"
                
            case LAError.InvalidContext.rawValue:
                message = "The context is invalid"
                
            case LAError.PasscodeNotSet.rawValue:
                message = "Passcode is not set on the device"
                
            case LAError.SystemCancel.rawValue:
                message = "Authentication was cancelled by the system"
                
            case LAError.TouchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.TouchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.UserCancel.rawValue:
                message = "The user did cancel"
                
            case LAError.UserFallback.rawValue:
                message = "The user chose to use the fallback"
                
            default:
                message = "Did not find error code on LAError object"
                
            }
        } else {
            // Fallback on earlier versions
        }
        
        return message
        
    }

    
    
    @IBAction func auth(sender: UIButton) {
        self.touchAuth()
        
        
    }
    

    
    
    
    

}


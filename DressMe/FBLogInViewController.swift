//
//  ViewController.swift
//  DressMe
//
//  Created by Hardik on 03/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FBLogInViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    lazy var loginButton:FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.center = self.view.center
        return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.readPermissions = [FBReadPermissionPublicProfile, FBReadPermissionEmail]
        loginButton.publishPermissions = [FBPublishPermissionActions]
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

        if error != nil {
            
            let alert = UIAlertController(title: AlertTitleFBLogInFailed, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: AlertButtonTitle, style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        AppDataSource.sharedState.saveAccessToken(result.token.tokenString)
        
        Router.pushClothPickerViewController(self.navigationController!)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //TODO : Handle logout
    }
}


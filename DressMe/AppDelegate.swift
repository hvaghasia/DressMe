//
//  AppDelegate.swift
//  DressMe
//
//  Created by Hardik on 03/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import UIKit
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    class func instance() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        if AppDataSource.sharedState.isUserLoggedIn() {
            
            let clothPickerVC = Router.clothViewControllerFromStoryBoard()
            let nav = UINavigationController(rootViewController: clothPickerVC)
            window?.rootViewController = nav
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationDidEnterBackground(application: UIApplication) {
        AppDataSource.sharedState.savePantImagesRelativePath()
        AppDataSource.sharedState.saveShirtImagesRelativePath()
        AppDataSource.sharedState.saveFavouritePairs()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        
        AppDataSource.sharedState.savePantImagesRelativePath()
        AppDataSource.sharedState.saveShirtImagesRelativePath()
        AppDataSource.sharedState.saveFavouritePairs()

    }


}


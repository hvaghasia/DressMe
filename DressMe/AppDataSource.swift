//
//  AppDataSource.swift
//  DressMe
//
//  Created by Hardik on 08/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation

class AppDataSource {
    
    class var sharedState : AppDataSource {
        struct Static {
            static let instance : AppDataSource = AppDataSource()
        }
        return Static.instance
    }
    
    lazy var shirtImagesRelativePath:  [String] = {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return (userDefaults.objectForKey(UserDefaultKeyShirtImagesRelativePath) ?? [String]()) as! [String]
    }()
    
    lazy var pantImagesRelativePath: [String] = {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return (userDefaults.objectForKey(UserDefaultKeyPantImagesRelativePath) ?? [String]()) as! [String]
        
        }()
    
    lazy var tokenString: String? = {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.objectForKey(UserDefaultKeyAccessToken) as? String
    }()
    
    var allRandomPairs: [Pair] {
        
        var pairs = [Pair]()
        
        for (_, shirtImageURL) in shirtImagesRelativePath.enumerate() {
            
            for (_, pantImageURL) in pantImagesRelativePath.enumerate() {
                let pair = Pair(shirtImagePath: shirtImageURL, pantImagePath: pantImageURL)

                if isProvidedPairFavourite(shirtImageURL, pantImagePath: pantImageURL) {
                    pair.isFavourite = true
                }
                pairs.append(pair)
            }
        }
        return pairs
    }
    
    lazy var favouritePairs: [Pair] = {
        
        var favouritePairs :[Pair]?
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let decoded  = userDefaults.objectForKey(UserDefaultKeyFavouritePairs) as? NSData
        if let decodedData = decoded {
            favouritePairs = NSKeyedUnarchiver.unarchiveObjectWithData(decodedData) as? [Pair]
        }
        
        return favouritePairs ?? [Pair]()
    }()
    
    
    func isUserLoggedIn() -> Bool {
        
        return (tokenString != nil)
    }
    
    func isProvidedPairFavourite(shirtImagePath: String, pantImagePath: String) -> Bool {
        
        let pairs = favouritePairs.filter { (pair) -> Bool in
            if let shirtImagePathString = pair.shirtImageRelativePath, let pantImagePathString = pair.pantImageRelativePath where shirtImagePathString == shirtImagePath && pantImagePathString == pantImagePath {
                return true
            }
            return false
        }
        
        return pairs.count > 0
    }
    
    func saveAccessToken(tokenString: String) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(tokenString, forKey: UserDefaultKeyAccessToken)
        userDefaults.synchronize()
    }
    
    func saveFavouritePairs() {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(favouritePairs)
        userDefaults.setObject(encodedData, forKey: UserDefaultKeyFavouritePairs)
        userDefaults.synchronize()
    }
    
    func saveShirtImagesRelativePath() {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(shirtImagesRelativePath, forKey: UserDefaultKeyShirtImagesRelativePath)
        userDefaults.synchronize()
    }
    
    func savePantImagesRelativePath() {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(pantImagesRelativePath, forKey: UserDefaultKeyPantImagesRelativePath)
        userDefaults.synchronize()
    }
}
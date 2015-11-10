//
//  Router.swift
//  DressMe
//
//  Created by Hardik on 09/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation


class Router {
    
    
    class func mainStroryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func clothViewControllerFromStoryBoard() -> ClothPickerViewController {
        
        let storyboard : UIStoryboard = mainStroryBoard()
        return storyboard.instantiateViewControllerWithIdentifier("ClothPickerViewController") as! ClothPickerViewController
    }
    
    class func pairPageViewController() -> UIPageViewController {
        
        let storyboard : UIStoryboard = mainStroryBoard()
        return storyboard.instantiateViewControllerWithIdentifier("PairPageViewController") as! UIPageViewController
    }
    
    class func pairViewController() -> PairViewController {
        
        let storyboard : UIStoryboard = mainStroryBoard()
        return storyboard.instantiateViewControllerWithIdentifier("PairViewController") as! PairViewController
    }
    
    class func pairSuggestionViewController() -> PairSuggestionViewController {
        
        let storyboard : UIStoryboard = mainStroryBoard()
        return storyboard.instantiateViewControllerWithIdentifier("PairSuggestionViewController") as! PairSuggestionViewController
    }
    
    class func pushFavouritePairsSuggestionViewController(target:AnyObject) {
        
        let vc = FavouritePairsSuggestionViewController()
        target.pushViewController(vc, animated: true)
    }
    
    class func pushRandomPairsSuggestionViewController(target:AnyObject) {
        
        let vc = RandomPairsSuggestionViewController()
        target.pushViewController(vc, animated: true)
    }
    
    class func pushClothPickerViewController(target:AnyObject) {
        
        let clothPickerVC = clothViewControllerFromStoryBoard()
        target.pushViewController(clothPickerVC, animated: true)
    }
    
    class func pushPairSuggestionsViewController(target:AnyObject) {
        
        let pairSuggestionVC = pairSuggestionViewController()
        target.pushViewController(pairSuggestionVC, animated: true)
    }
    
    
}
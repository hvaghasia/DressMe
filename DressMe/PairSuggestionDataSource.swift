//
//  PairSuggestionDataSource.swift
//  DressMe
//
//  Created by Hardik on 09/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation


class PairSuggestionDataSource : NSObject, UserActionDelegate {
    
    var allPairs = [Pair]()
    weak var pageViewController: UIPageViewController!
    var curruntPageIndex = 0
    var shouldDisplayShareButton = false
    
    func userLikedPairForIndex(pageIndex: Int) {
        
        let pair = allPairs[pageIndex]
        pair.isFavourite = true
        AppDataSource.sharedState.favouritePairs.append(pair)
    }
    
    func userResetLikedPairForIndex(pageIndex: Int) {
        let pair = allPairs[pageIndex]
        let pairIndex = AppDataSource.sharedState.favouritePairs.indexOf(pair)
        AppDataSource.sharedState.favouritePairs.removeAtIndex(pairIndex!)
    }
    
    func userDislikedPairForIndex(pageIndex: Int) {
        
        curruntPageIndex = pageIndex + 1
        if let pairVC = viewControllerForPage(curruntPageIndex) {
            pageViewController.setViewControllers([pairVC], direction: .Forward, animated: true, completion: nil)
        }
    }
}


extension PairSuggestionDataSource : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let pairVC = viewController as! PairViewController
        let pageIndex = pairVC.pageIndex + 1
        curruntPageIndex = pageIndex

        return viewControllerForPage(pageIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let pairVC = viewController as! PairViewController
        let pageIndex = pairVC.pageIndex - 1
        curruntPageIndex = pageIndex
        return viewControllerForPage(pageIndex)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return allPairs.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return curruntPageIndex
    }
    
    func viewControllerForPage(page: Int) -> UIViewController? {
        if page >= 0 && page < allPairs.count {
            
            let pairViewController = Router.pairViewController()
            pairViewController.pageIndex = page
            pairViewController.pair = allPairs[page]
            pairViewController.delegate = self
            return pairViewController
        }
        
        return nil
    }
}

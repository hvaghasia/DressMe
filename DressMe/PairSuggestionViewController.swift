//
//  PairSuggestionViewController.swift
//  DressMe
//
//  Created by Hardik on 09/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation
import UIKit

class PairSuggestionViewController: UIViewController {
    
    lazy var pageViewController: UIPageViewController = {
        return Router.pairPageViewController()
    }()
    
    var pairSuggestionsDataSource: PairSuggestionDataSource {
        get {
            return PairSuggestionDataSource()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = pairSuggestionsDataSource
        dataSource.pageViewController = pageViewController
        pageViewController.dataSource = dataSource
        
        if dataSource.allPairs.count == 0 {
            addNoContentLabel()
            return
        }
        
        if let pairVC = dataSource.viewControllerForPage(0) {
            pageViewController.setViewControllers([pairVC], direction: .Forward, animated: false, completion: nil)
        }
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }
    
    func addNoContentLabel() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        let noContentMsgLabel = UILabel()
        noContentMsgLabel.text = LabelTextNoContent
        noContentMsgLabel.textAlignment = .Center
        noContentMsgLabel.font = UIFont.systemFontOfSize(CGFloat(LabelFontSizeNoContent))
        noContentMsgLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noContentMsgLabel)
        
        let verticalConstraint = NSLayoutConstraint(item: noContentMsgLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        
        let leading = NSLayoutConstraint(item: noContentMsgLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        view.addConstraint(leading)
        
        let trailing = NSLayoutConstraint(item: noContentMsgLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        view.addConstraint(trailing)
    }
}
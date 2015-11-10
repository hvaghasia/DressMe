//
//  ClothPickerButton.swift
//  DressMe
//
//  Created by Hardik on 10/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation
import UIKit

class ClothPickerButton: UIButton {
    
    private var buttonSize: CGFloat = 150
    
    convenience init(title: String, bkgColor: UIColor, buttonSize: CGFloat, action: Selector, target: AnyObject) {
        
        self.init()
        
        self.setTitle(title, forState: .Normal)
        self.backgroundColor = bkgColor
        self.layer.cornerRadius = 0.5 * buttonSize
        self.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.buttonSize = buttonSize

    }
    
    func applyConstraints(var constraintsToSuperView: [NSLayoutConstraint]) {
        
        let horizontalCenter = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.superview, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        constraintsToSuperView.append(horizontalCenter)
        
        self.superview?.addConstraints(constraintsToSuperView)
        
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: self.buttonSize)
        self.addConstraint(height)
        
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: self.buttonSize)
        self.addConstraint(width)
    }
}

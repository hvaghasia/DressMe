//
//  PairViewController.swift
//  DressMe
//
//  Created by Hardik on 09/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation
import UIKit
import FBSDKShareKit
import FBSDKCoreKit

class PairViewController: UIViewController {
    
    @IBOutlet weak var shirtImageView: UIImageView!
    @IBOutlet weak var pantImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    var delegate: UserActionDelegate?
    
    var pageIndex: Int = 0
    var pair: Pair?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pair_ = pair, let shirtImageRelPath_ = pair_.shirtImageRelativePath, let pantImageRelPath_ = pair_.pantImageRelativePath {
            
            let shirtImage = Utils.imageFromRelativePath(shirtImageRelPath_)
            let resizedShirtImage = Utils.resizeImage(shirtImage, targetSize: CGSizeMake(CGRectGetWidth(shirtImageView.frame), CGRectGetHeight(shirtImageView.frame)))
            shirtImageView.image = resizedShirtImage
            
            let pantImage = Utils.imageFromRelativePath(pantImageRelPath_)
            let resizedPantImage = Utils.resizeImage(pantImage, targetSize: CGSizeMake(CGRectGetWidth(shirtImageView.frame), CGRectGetHeight(shirtImageView.frame)))
            pantImageView.image = resizedPantImage
        }
        
        
        if let pair_ = pair where pair_.isFavourite {
            likeButton.selected = true
        }
        
        if let d = delegate where d.shouldDisplayShareButton {
            shareButton.hidden = false
        }
    }
    
    func postPairScreenshotOnFB() {
        
        let progressView = MBProgressHUD.showHUDAddedTo(AppDelegate.instance().window, animated: true)
        progressView.labelText = SpinnerViewTitleSharingPhoto
        
        let image = Utils.screenShotImageOfView(self.view)
        
        let photo = FBSDKSharePhoto()
        photo.image = image
        photo.userGenerated = true
        let photoContent = FBSDKSharePhotoContent()
        photoContent.photos = [photo]
        FBSDKShareAPI.shareWithContent(photoContent, delegate: self)
    }
    
    //MARK : IBActions
    
    @IBAction func likeButtonTapped(sender: UIButton) {
        
        if likeButton.selected {
            delegate?.userResetLikedPairForIndex(pageIndex)
        } else {
            delegate?.userLikedPairForIndex(pageIndex)
        }
        
        likeButton.selected = !likeButton.selected
    }
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
        self.likeButton.hidden = true
        self.dislikeButton.hidden = true
        self.shareButton.hidden = true
        
        postPairScreenshotOnFB()
        
        self.likeButton.hidden = false
        self.dislikeButton.hidden = false
        self.shareButton.hidden = false
    }
    
    @IBAction func dislikeButtonTapped(sender: AnyObject) {
        
        delegate?.userDislikedPairForIndex(pageIndex)
    }
}


extension PairViewController: FBSDKSharingDelegate {
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("didCompleteWithResults : \(results)")
        MBProgressHUD.hideHUDForView(AppDelegate.instance().window, animated: true)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        
        MBProgressHUD.hideHUDForView(self.view.window, animated: true)
        
        let alert = UIAlertController(title: AlertTitlePhotoSharingFailed, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: AlertButtonTitle, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel)")
        
    }
}
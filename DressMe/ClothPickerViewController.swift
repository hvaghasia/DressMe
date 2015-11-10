//
//  ClothPickerViewController.swift
//  DressMe
//
//  Created by Hardik on 08/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation
import Photos


public enum ClothType: Int {
    case Shirt
    case Pant
}

class ClothPickerViewController: UIViewController {
    
    lazy var requestOption:PHImageRequestOptions = {
        return PHImageRequestOptions()
    }()
    
    var isPickingShirts: Bool = false
    var savedImageCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestOption.resizeMode = .Exact;
        requestOption.deliveryMode = .HighQualityFormat;
        
        title = ScreenTitleClothPickerViewController
        
        addNavigationBarButton()
        
        addClothPickerButton()
    }
    
    func addClothPickerButton() {
        
        // Create and display pick Shirts button
        let shirtButton = ClothPickerButton(title: ButtonTitlePickShirts, bkgColor: UIColor.redColor(), buttonSize: ButtonSizePickShirts, action: Selector("pickShirts"), target: self)
        view.addSubview(shirtButton)
        
        var top = NSLayoutConstraint(item: shirtButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: TopPaddingPickShirtsButton)
        shirtButton.applyConstraints([top])
        
        // Create and display pick pants button
        let pantButton = ClothPickerButton(title: ButtonTitlePickPants, bkgColor: UIColor.blueColor(), buttonSize: ButtonSizePickPants, action: Selector("pickPants"), target: self)
        view.addSubview(pantButton)
        
        top = NSLayoutConstraint(item: pantButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: shirtButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: TopPaddingPickPantsButton)
        pantButton.applyConstraints([top])
    }
    
    func addNavigationBarButton() {
        let rightNavButton = UIBarButtonItem(title: ButtonTitleSuggestions, style: .Plain, target: self, action: Selector("showPairSuggestions"))
        navigationItem.rightBarButtonItem = rightNavButton
        
        let letNavButton = UIBarButtonItem(title: ButtonTitleFavourites, style: .Plain, target: self, action: Selector("showFavouritePairs"))
        navigationItem.leftBarButtonItem = letNavButton
    }
    
    func presentPhotoPicker() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] (status) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
                
                if self == nil {return}
                let picker = CTAssetsPickerController()
                picker.delegate = self!
                
                self!.presentViewController(picker, animated: true, completion: nil)
            })
        }
    }
    
    func showPairSuggestions() {
        Router.pushRandomPairsSuggestionViewController(self.navigationController!)
    }
    
    func showFavouritePairs() {
        Router.pushFavouritePairsSuggestionViewController(self.navigationController!)
    }
    
    //MARK : IBActions
    
    func pickPants() {
        isPickingShirts = false
        presentPhotoPicker()
    }
    
    func pickShirts() {
        isPickingShirts = true
        presentPhotoPicker()
    }
}

extension ClothPickerViewController: CTAssetsPickerControllerDelegate {
    
    func assetsPickerControllerDidCancel(picker: CTAssetsPickerController!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func assetsPickerController(picker: CTAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        // Display spinner until images gets saved
        let progressView = MBProgressHUD.showHUDAddedTo(AppDelegate.instance().window, animated: true)
        progressView.labelText = SpinnerViewTitleSavingPhotos

        self.savedImageCount = assets.count

        for asset in assets {
            let pickedAsset = asset as! PHAsset
            
            let manager = PHImageManager.defaultManager()
            manager.requestImageDataForAsset(pickedAsset, options: requestOption, resultHandler: { [weak self] (imageData, string, orientation, info) -> Void in
                
                if self == nil {return}
                
                if let dic = info {
                    
                    let filePath = dic[NSString(string: "PHImageFileURLKey")] as! NSURL
                    let pathExtension = filePath.pathExtension!
                    
                    self!.saveImage(imageData, imageUniqId: pickedAsset.localIdentifier, pathExtension: pathExtension)
                }
            })
        }
    }
    
    func saveImage(imageData: NSData?, var imageUniqId: String, pathExtension:String) {
    
        if let imageData = imageData {
            
            if let slashRange = imageUniqId.rangeOfString("/") {
                imageUniqId = imageUniqId.substringToIndex(slashRange.startIndex)
            }
            
            var attachmentPath = ""
            
            if self.isPickingShirts {
                attachmentPath = Utils.pathForClothImages(imageUniqId, clothType: ClothType.Shirt)
            } else {
                attachmentPath = Utils.pathForClothImages(imageUniqId, clothType: ClothType.Pant)
            }
            
            // add file extension
            if pathExtension.isEmpty == false {
                attachmentPath = attachmentPath + "." + pathExtension
            }
            
            // Get relative path for images and add them to AppDataSource so we can persiste for later use
            let relativePath = Utils.relativePathFromAttachmentDirectoryForPath(attachmentPath)
            if self.isPickingShirts {
                AppDataSource.sharedState.shirtImagesRelativePath.append(relativePath!)
            } else {
                AppDataSource.sharedState.pantImagesRelativePath.append(relativePath!)
            }
            
            do {
                try imageData.writeToFile(attachmentPath, options: .AtomicWrite)
                
            } catch {
                print(error)
            }
            
            savedImageCount -= 1
            if savedImageCount == 0 {
                MBProgressHUD.hideHUDForView(AppDelegate.instance().window, animated: true)
            }
            
        }
    }
    
}
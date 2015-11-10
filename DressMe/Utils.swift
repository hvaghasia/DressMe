//
//  Utils.swift
//  DressMe
//
//  Created by Hardik on 08/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation

class Utils {
    
    class func applicationName() -> String {
    
        let infoDictionary: NSDictionary = NSBundle.mainBundle().infoDictionary as NSDictionary!
        return infoDictionary.objectForKey("CFBundleName") as! String
    }
    
    class func pathForClothImages(imageID:String, clothType: ClothType) -> String {
        let uploadedAttachmentDirectory = imageStorageDirectory(clothType)
        let attachmentPath =  uploadedAttachmentDirectory + imageID
        
        print("Asset Path : \(attachmentPath)")
        return attachmentPath
    }
    
    class func relativePathFromAttachmentDirectoryForPath(path: String) -> String? {
        
        var relativePath: String? = nil
        let pathRange:Range<String.Index> = Range<String.Index>(start: path.startIndex, end: path.endIndex)
        
        if let documentDirectoryRange = path.rangeOfString(applicationName(), options: NSStringCompareOptions.CaseInsensitiveSearch, range: pathRange, locale: NSLocale.currentLocale()) {
            
            relativePath = path.substringFromIndex(documentDirectoryRange.endIndex)
        }
        
        return relativePath
    }
    
    class func absoluteFullPathForPath(path: String) -> String {
        
        let documentDirectory = documentsDirectory()
        let uploadedAttachmentsPath = documentDirectory + path
        
        return uploadedAttachmentsPath
    }
    
    class func documentsDirectory() -> String {
        let applicationStorageDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!  + "/" + applicationName()
        return applicationStorageDirectory
    }
    
    class func imageStorageDirectory(clothType: ClothType) -> String {
        
        var dir = documentsDirectory() + "/"

        if clothType == .Pant {
            dir += "PantImages/"
        } else if clothType == .Shirt {
            dir += "ShirtImages/"
        }
        
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(dir, withIntermediateDirectories: true, attributes: nil)

        } catch {
            print("Error occured")
        }
        
        return dir
    }
    
    class func imageFromRelativePath(relativePath: String) -> UIImage? {
        let absPath = absoluteFullPathForPath(relativePath)
        return UIImage(contentsOfFile: absPath)
    }
    
    
    
    
    
    
    
    
    class func screenShotImageOfView(view: UIView) -> UIImage {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return image
    }
    
    
    
    class func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        
        if let image = image {
            let size = image.size
            
            let widthRatio  = targetSize.width  / image.size.width
            let heightRatio = targetSize.height / image.size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
            } else {
                newSize = CGSizeMake(size.width * widthRatio,  size.height *  widthRatio)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRectMake(0, 0, newSize.width, newSize.height)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.drawInRect(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        } else {
            return nil
        }
    }

}

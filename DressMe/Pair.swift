//
//  Pair.swift
//  DressMe
//
//  Created by Hardik on 08/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation

class Pair: NSObject, NSCoding {
    
    var shirtImageRelativePath:String?
    var pantImageRelativePath:String?
    var isFavourite: Bool = false
    
    init(shirtImagePath: String, pantImagePath: String, isFavourite: Bool = false) {
        self.shirtImageRelativePath = shirtImagePath
        self.pantImageRelativePath = pantImagePath
        self.isFavourite = isFavourite
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let shirtImageRelativePath = aDecoder.decodeObjectForKey("shirtImageRelativePath") as! String
        let pantImageRelativePath = aDecoder.decodeObjectForKey("pantImageRelativePath") as! String
        let isFavourite = aDecoder.decodeBoolForKey("isFavourite")
        
        self.init(shirtImagePath:shirtImageRelativePath, pantImagePath:pantImageRelativePath, isFavourite: isFavourite)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(shirtImageRelativePath, forKey: "shirtImageRelativePath")
        aCoder.encodeObject(pantImageRelativePath, forKey: "pantImageRelativePath")
        aCoder.encodeBool(isFavourite, forKey: "isFavourite")

    }
}

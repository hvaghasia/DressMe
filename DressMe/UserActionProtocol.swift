//
//  UserActionProtocol.swift
//  DressMe
//
//  Created by Hardik on 10/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//


protocol UserActionDelegate {
    
    var shouldDisplayShareButton: Bool {get set}
    
    func userLikedPairForIndex(pageIndex: Int)
    func userResetLikedPairForIndex(pageIndex: Int)
    func userDislikedPairForIndex(pageIndex: Int)
}
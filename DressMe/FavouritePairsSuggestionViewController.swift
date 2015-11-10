//
//  FavouritePairsSuggestionViewController.swift
//  DressMe
//
//  Created by Hardik on 09/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation


class FavouritePairsSuggestionViewController: PairSuggestionViewController {
    
    override var pairSuggestionsDataSource: PairSuggestionDataSource {
        get {
            let dataSource = PairSuggestionDataSource()
            dataSource.allPairs = AppDataSource.sharedState.favouritePairs
            dataSource.shouldDisplayShareButton = true
            return dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ScreenTitleFavouritePairsViewController
    }
    
}
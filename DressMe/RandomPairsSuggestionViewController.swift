//
//  RandomPairSuggestionsViewController.swift
//  DressMe
//
//  Created by Hardik on 09/11/15.
//  Copyright © 2015 Hardik. All rights reserved.
//

import Foundation


class RandomPairsSuggestionViewController: PairSuggestionViewController {

    override var pairSuggestionsDataSource: PairSuggestionDataSource {
        get {
            let dataSource = PairSuggestionDataSource()
            dataSource.allPairs = AppDataSource.sharedState.allRandomPairs
            dataSource.shouldDisplayShareButton = false
            return dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ScreenTitleRandomPairsViewController
    }
}

//
//  SubredditSelectionDelegate.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 05/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

protocol SubredditSelectionDelegate : class {
    func selected(subreddit : Subreddit)
}

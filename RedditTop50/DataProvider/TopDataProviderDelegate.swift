//
//  DataProvider.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

protocol TopDataProviderDelegate : class {
   
    func success(data : [Subreddit], last : String)
    func error(error : ErrorData)
}



//
//  TopResponse.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

// MARK: - TopResponse
struct TopResponse: Codable {
    let kind: String?
    let data: TopResponseData?
}

// MARK: - TopResponseData
struct TopResponseData: Codable {
    let modhash: String?
    let children: [Subreddit]?
    let after: String?
    let before: String?
}


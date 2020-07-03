//
//  Media.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

// MARK: - Media
struct Media: Codable {
    let oembed: Oembed?
    let type: String?
}

// MARK: - MediaEmbed
struct MediaEmbed: Codable {
    let content: String?
    let width: Int?
    let scrolling: Bool?
    let height: Int?
}

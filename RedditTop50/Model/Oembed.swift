//
//  Oembed.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

struct Oembed: Codable {
    let providerURL: String?
    let oembedDescription, title: String?
    let url: String?
    let type, authorName: String?
    let height, width: Int?
    let html: String?
    let thumbnailWidth: Int?
    let version, providerName: String?
    let thumbnailURL: String?
    let thumbnailHeight: Int?
    let authorURL: String?

    enum CodingKeys: String, CodingKey {
        case providerURL = "provider_url"
        case oembedDescription = "description"
        case title, url, type
        case authorName = "author_name"
        case height, width, html
        case thumbnailWidth = "thumbnail_width"
        case version
        case providerName = "provider_name"
        case thumbnailURL = "thumbnail_url"
        case thumbnailHeight = "thumbnail_height"
        case authorURL = "author_url"
    }
}

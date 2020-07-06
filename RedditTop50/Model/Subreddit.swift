import Foundation


// MARK: - Subreddit
struct Subreddit: Codable {
    let kind: String?
    let data: SubredditData?
}

// MARK: - SubredditData
struct SubredditData: Codable {
    let domain: String?
    let mediaEmbed: MediaEmbed?
    let subreddit: String?
    let selftextHTML: String?
    let selftext: String?
    let secureMedia: Media?
    let linkFlairText: String?
    let id: String?
    let gilded: Int?
    let secureMediaEmbed: MediaEmbed?
    let clicked: Bool?
    let author: String?
    let media: Media?
    let score: Int?
    let over18, hidden: Bool?
    let thumbnail: String?
    let subredditID: String?
    let linkFlairCSSClass: String?
    let downs: Int?
    let saved, isSelf: Bool?
    let name, permalink: String?
    let stickied: Bool?
    let created: Int?
    let url: String?
    let title: String?
    let createdUTC : Int64?
    let ups, numComments: Int?
    let visited: Bool?

    enum CodingKeys: String, CodingKey {
        case domain
        case mediaEmbed = "media_embed"
        case subreddit
        case selftextHTML = "selftext_html"
        case selftext
        case secureMedia = "secure_media"
        case linkFlairText = "link_flair_text"
        case id, gilded
        case secureMediaEmbed = "secure_media_embed"
        case clicked
        case author, media, score
        case over18 = "over_18"
        case hidden, thumbnail
        case subredditID = "subreddit_id"
        case linkFlairCSSClass = "link_flair_css_class"
        case downs
        case saved
        case isSelf = "is_self"
        case name, permalink, stickied, created, url
        case title
        case createdUTC = "created_utc"
        case ups
        case numComments = "num_comments"
        case visited

    }
}







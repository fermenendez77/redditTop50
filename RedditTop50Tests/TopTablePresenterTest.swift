//
//  TopTablePresenterTest.swift
//  RedditTop50Tests
//
//  Created by Fernando Menendez on 06/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import XCTest
@testable import RedditTop50

class TopTablePresenterTest: XCTestCase {
    
    var presenter : TopTablePresenterImp?
    let dataProvider : TopDataProvider = MockTopDataProvider()

    override func setUp() {
        presenter = TopTablePresenterImp(withView: self, dataProvider: dataProvider)
    }
    
    func testRequestData() {
        presenter?.viewDidLoad()
        XCTAssert(presenter!.subreddits.count > 0)
        let resultCount = presenter?.receivedItemsCount
        presenter?.fetchData()
        XCTAssert(presenter!.subreddits.count > resultCount!)
    }
    
    func testDeleteAll() {
        presenter?.viewDidLoad()
        presenter?.deleteAll()
        XCTAssert(presenter!.subreddits.count == 0)
    }
}

extension TopTablePresenterTest : TopTableView {
    
    func loadElements() {
        
    }
    
    func appendElements(fromRow from: Int, toRow to: Int) {
        
    }
    
    func showDetail() {
        
    }
    
    func reloadCell(at indexPath: IndexPath) {
        
    }
    
    func showError() {
        
    }
    
    
}

class MockTopDataProvider : TopDataProvider {
    
    var delegate: TopDataProviderDelegate?
    
    func requestData(nextElements: Int, after: String?) {
        delegate?.success(data: subReddits, last: "last")
    }
    
    
    
    var subReddits : [Subreddit] {
        return [Subreddit(kind: "t0", data: nil),
                Subreddit(kind: "t1", data: nil),
                Subreddit(kind: "t2", data: nil),
                Subreddit(kind: "t3", data: SubredditData(domain: nil,
                                                          mediaEmbed: nil, subreddit: nil,
                                                          selftextHTML: nil, selftext: nil,
                                                          secureMedia: nil, linkFlairText: nil,
                                                          id: nil, gilded: nil, secureMediaEmbed: nil,
                                                          clicked: nil, author: "Fernando", media: nil,
                                                          score: 3000, over18: false, hidden: false,
                                                          thumbnail: "http://image.com", subredditID: nil,
                                                          linkFlairCSSClass: nil, downs: nil,
                                                          saved: nil, isSelf: nil,
                                                          name: "Name", permalink: nil,
                                                          stickied: nil, created: 545212145,
                                                          url: nil, title: "Title",
                                                          createdUTC: 545212145, ups: nil,
                                                          numComments: nil, visited: nil))]
    }
    
    
}

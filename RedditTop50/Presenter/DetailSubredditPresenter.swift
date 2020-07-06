//
//  DetailSubredditPresenter.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 04/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

protocol DetailSubredditPresenter : class {
    
    var subreddit : Subreddit? { get set }
    var view : DetailSubRedditView? { get set }
    func loadInfo()
}

class DetailSubredditPresenterImp : DetailSubredditPresenter {
    
    weak var view: DetailSubRedditView?
    var subreddit: Subreddit?
    
    init(withView view : DetailSubRedditView? = nil) {
        self.view = view
    }
    
    func loadInfo() {
        guard let data = subreddit?.data else {
            return
        }
        view?.configure(author: data.author!)
        view?.configure(title: data.title!)
        view?.configure(imageURL: data.thumbnail!)
    }

}

extension DetailSubredditPresenterImp : SubredditSelectionDelegate {
    
    func selected(subreddit: Subreddit) {
        self.subreddit = subreddit
        loadInfo()
    }
    
}





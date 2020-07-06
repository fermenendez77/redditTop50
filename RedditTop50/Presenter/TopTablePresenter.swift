//
//  TopTablePresenter.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol TopTablePresenter : class {
    
    var receivedItemsCount : Int { get }
    func viewDidLoad()
    func configure(cell : SubRedditViewCell, atIndexPath indexPath : IndexPath)
    func delete(atIndexPath indexPath : IndexPath)
    func deleteAll()
    func fetchData()
    func selectedRow(at indexPath : IndexPath)
}

class TopTablePresenterImp : TopTablePresenter {

    internal var dataProvider : TopDataProvider
    internal weak var view : TopTableView?
    internal weak var selectionDelegate : SubredditSelectionDelegate?
    
    init(withView view : TopTableView, dataProvider : TopDataProvider = TopDataProviderImp()) {
        self.dataProvider = dataProvider
        self.view = view
    }
    
    public var subreddits : [Subreddit] = []
    public var receivedItemsCount : Int {
        return subreddits.count
    }
    
    var pendingImagesOperations : [IndexPath : ImageDownloaderOperation] = [:]
    var images : [IndexPath : UIImage] = [:]
    var imageQueue : OperationQueue = OperationQueue()

    var lastId : String?
    let requestItems = 20
    
    func viewDidLoad() {
        dataProvider.delegate = self
        fetchData()
    }
    
    func configure(cell : SubRedditViewCell, atIndexPath indexPath : IndexPath) {
        let subreddit = subreddits[indexPath.row]
        guard let cellData = subreddit.data else {
            return
        }
        cell.configure(title: cellData.title!)
        cell.configure(author: cellData.author!)
        cell.configure(created: String(cellData.created!))
        cell.configure(points: String(cellData.score!))
        
        if let image = images[indexPath] {
            cell.hideLoader()
            cell.configure(image: image)
        } else {
            guard pendingImagesOperations[indexPath] == nil else {
                return
            }
            cell.showLoader()
            let operation = ImageDownloaderOperation(withURL: URL(string: cellData.thumbnail!)!)
            operation.completionBlock = { [weak self] in
                if let image = operation.image {
                    DispatchQueue.main.async {
                        self?.images[indexPath] = image
                        self?.pendingImagesOperations.removeValue(forKey: indexPath)
                        self?.view?.reloadCell(at: indexPath)
                    }
                }
            }
            pendingImagesOperations[indexPath] = operation
            imageQueue.addOperation(operation)
        }
    }
    
    func delete(atIndexPath indexPath: IndexPath) {
        subreddits.remove(at: indexPath.row)
    }
    
    func deleteAll() {
        subreddits.removeAll()
        lastId = nil
        images.removeAll()
        view?.loadElements()
    }
    
    func fetchData() {
        dataProvider.requestData(nextElements: requestItems, after: lastId)
    }
    
    func selectedRow(at indexPath: IndexPath) {
        let subreddit = subreddits[indexPath.row]
        selectionDelegate?.selected(subreddit: subreddit)
        view?.showDetail()
    }
    
}

extension TopTablePresenterImp : TopDataProviderDelegate {
    
    func success(data: [Subreddit], last: String) {
        lastId = last
        if (subreddits.isEmpty) {
            subreddits = data
            view?.loadElements()
            selectionDelegate?.selected(subreddit: subreddits.first!)
        } else {
            let lastRequestedItems = receivedItemsCount
            subreddits.append(contentsOf : data)
            view?.appendElements(fromRow: lastRequestedItems,
                                 toRow: receivedItemsCount)
        }
        
    }
    
    func error(error: ErrorData) {
        
    }

}

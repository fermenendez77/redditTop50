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
    var subreddits : [Subreddit] { get }
    var requestedItems : Int { get }
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
    
    internal var subreddits : [Subreddit] = []
    public var receivedItemsCount : Int {
        return subreddits.count
    }
    
    internal var pendingImagesOperations : [IndexPath : ImageDownloaderOperation] = [:]
    internal var images : [IndexPath : UIImage] = [:]
    internal var readedIds : [String] = []
    var imageQueue : OperationQueue = OperationQueue()

    var lastId : String?
    public var requestedItems = 0
    public let requestItems = 10
    
    func viewDidLoad() {
        dataProvider.delegate = self
        fetchData()
    }
    
    func configure(cell : SubRedditViewCell, atIndexPath indexPath : IndexPath) {
        let subreddit = subreddits[indexPath.row]
        guard let cellData = subreddit.data else {
            return
        }
        cell.configure(title: cellData.title ?? "No Title")
        cell.configure(author: cellData.author ?? "No Author")
        cell.configure(created: formatCreatedString(with: cellData))
        cell.configure(points: String(cellData.score ?? 0))
        if let id = cellData.id {
            cell.configure(readed: readedIds.contains(id))
        }
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
    
    func formatCreatedString(with subredditData : SubredditData) -> String {
       
        let createdDate = Date(timeIntervalSince1970: Double(subredditData.createdUTC!))
        let now = Date()
        let difference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: createdDate, to: now)
        
        if difference.minute! >= 1{
            return String(describing: difference.minute!) + " min ago"
        } else {
            return String(describing: difference.hour!) + " hour ago"
        }
    }
    
    func delete(atIndexPath indexPath: IndexPath) {
        subreddits.remove(at: indexPath.row)
    }
    
    func deleteAll() {
        subreddits.removeAll()
        lastId = nil
        requestedItems = 0
        images.removeAll()
        view?.loadElements()
    }
    
    func fetchData() {
        if (requestedItems < 50) {
            requestedItems += requestItems
            dataProvider.requestData(nextElements: requestItems, after: lastId)
        }
    }
    
    func selectedRow(at indexPath: IndexPath) {
        let subreddit = subreddits[indexPath.row]
        if let id = subreddit.data?.id {
            readedIds.append(id)
        }
        readedIds.append(subreddit.data!.id!)
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
        view?.showError()
    }

}

//
//  ViewController.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit

protocol TopTableView : class {
    
    func loadElements()
    func appendElements(fromRow from : Int, toRow to : Int)
    func showDetail()
    func reloadCell(at indexPath : IndexPath)
}

class TopTableViewController: UITableViewController {
    
    lazy var fetchingDataAlert : UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
    
    var presenter : TopTablePresenter?
    private let pullRefreshControll = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureRefreshControl()
        tableView.prefetchDataSource = self
        showProgressFetchingDataAlert()
        presenter?.viewDidLoad()
    }
    
    func configureNavBar() {
        self.title = "Top 50"
        let image = UIImage(systemName: "trash")
        let dismissAllButton = UIBarButtonItem(image: image,
                                               style: .plain,
                                               target: self,
                                               action: #selector(dismissAllPressed))
        dismissAllButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        navigationItem.rightBarButtonItem = dismissAllButton
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = pullRefreshControll
        pullRefreshControll.addTarget(self, action: #selector(pullRefreshData(_:)), for: .valueChanged)
    }
    
    func showProgressFetchingDataAlert() {
        present(fetchingDataAlert, animated: true, completion: nil)
    }
    
    func hideProgressFetchingDataAlert() {
        fetchingDataAlert.dismiss(animated: true, completion: nil)
    }
    
    @objc private func pullRefreshData(_ sender: Any) {
        presenter?.deleteAll()
        presenter?.fetchData()
    }
    
    @objc private func dismissAllPressed(){
        presenter?.deleteAll()
    }
    
    // MARK: UITableView Delegate and Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath) as! SubRedditViewCell
        presenter?.configure(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.receivedItemsCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        SubRedditViewCell.estimatedHeight
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.delete(atIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.selectedRow(at: indexPath)
    }
}

extension TopTableViewController : UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        if (indexPaths.last!.row < 4) {
            presenter?.fetchData()
        }
    }
}

extension TopTableViewController : TopTableView {
    
    func reloadCell(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    
    func showDetail() {
        if let splitVC = navigationController?.splitViewController as? MainSplitViewController {
            splitVC.showDetail()
        }
    }
    
    func appendElements(fromRow from: Int, toRow to : Int) {
        let indexPaths = (from..<(to)).map { IndexPath(row: $0, section: 0) }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
    
    func loadElements() {
        hideProgressFetchingDataAlert()
        pullRefreshControll.endRefreshing()
        tableView.reloadData()
    }
}


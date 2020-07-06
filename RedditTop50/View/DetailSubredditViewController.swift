//
//  DetailSubredditViewController.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 04/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit

protocol DetailSubRedditView : class {
    
    func configure(title : String)
    func configure(author : String)
    func configure(imageURL : String)
}

class DetailSubredditViewController: UIViewController {
    
    var presenter : DetailSubredditPresenter?
    let defaultImage = UIImage(named: "image-placeholder")
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 2.0
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = defaultImage
    }
}

extension DetailSubredditViewController : DetailSubRedditView {
    
    func configure(title: String) {
        loadViewIfNeeded()
        titleLabel.text = title
    }
    
    func configure(author: String) {
        loadViewIfNeeded()
        authorLabel.text = author
    }
    
    func configure(imageURL : String) {
        loadViewIfNeeded()
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string : imageURL),
                  let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.async {
                        self?.imageView.image = self?.defaultImage
                    }
                    return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.imageView?.image = image
                }
            }
        }
    }
    
    
}

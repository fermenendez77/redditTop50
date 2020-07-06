//
//  SubRedditViewCell.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 04/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation
import UIKit

class SubRedditViewCell : UITableViewCell {
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    static let estimatedHeight : CGFloat = 140.0
    
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 5.0
            thumbnailImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            thumbnailImageView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timeCreatedLabel: UILabel!
    
    func configure(author : String) {
        authorLabel.text = author
    }
    
    func configure(title : String) {
        titleLabel.text = title
       
    }
    
    func configure(points : String) {
        pointsLabel.text = points
    }
    
    func configure(created : String) {
        timeCreatedLabel.text = created
    }
    
    func showLoader() {
        thumbnailImageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func configure(image : UIImage) {
        thumbnailImageView.image = image
    }
    
}

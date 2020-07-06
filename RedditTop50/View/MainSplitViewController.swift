//
//  MainSplitViewController.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 04/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation
import UIKit

class MainSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    var detailViewController : DetailSubredditViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .primaryOverlay
        self.detailViewController = viewControllers[1] as? DetailSubredditViewController
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
           return false
        } else{
           return true
        }
    }
    
    
    func showDetail() {
        
        if let detailViewController = self.detailViewController {
            showDetailViewController(detailViewController, sender: nil)
        }
    }
}

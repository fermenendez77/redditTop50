//
//  ViewController.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    
    func getData() {
        let url = URL(string: "https://www.reddit.com/r/all/top.json?limit=10&t=hour")!
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let topResponse = try jsonDecoder.decode(TopResponse.self, from: data)
                print(topResponse)
            } catch {
                print(error)
            }
        }.resume()
    }

}


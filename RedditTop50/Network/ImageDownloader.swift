//
//  ImageDownloader.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 05/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation
import UIKit.UIImage

class ImageDownloaderOperation : Operation {
    
    let thumbnailURL : URL
    var image : UIImage?
    
    init(withURL url : URL) {
        thumbnailURL = url
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: thumbnailURL) else {
            self.image = UIImage(named: "image-placeholder")
            return
        }
        
        if isCancelled {
            return
        }
        
        if (!imageData.isEmpty) {
            self.image = UIImage(data: imageData)
        } else {
            self.image = UIImage(named: "image-placeholder")
        }
    }
}

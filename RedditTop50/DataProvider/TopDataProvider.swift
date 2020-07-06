//
//  TopDataProvider.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

protocol TopDataProvider {
    
    var delegate : TopDataProviderDelegate? { get set }
    func requestData(nextElements : Int, after : String?)
}

class TopDataProviderImp : TopDataProvider {
    
    weak var delegate : TopDataProviderDelegate?
    var clientService = RestClientService(urlBase: baseURL)
    let endPoint = "/r/all/top.json"
    
    func requestData(nextElements : Int, after : String?) {
        var queryItems : [URLQueryItem] = []
        if let afterId = after {
            queryItems.append(URLQueryItem(name: "after", value: afterId))
        }
        queryItems.append(URLQueryItem(name: "limit", value: String(nextElements)))
        queryItems.append(URLQueryItem(name: "t", value: "hour"))
        clientService.dataRequest(endpoint: endPoint,
                                  queryItems: queryItems,
                                  returnType: TopResponse.self,
                                  completionHandler: { [weak self] topResponse in
                                    guard let subReddits = topResponse.data?.children,
                                        let lastElement = topResponse.data?.after else {
                                            self?.delegate?.error(error: .badFormatError)
                                            return
                                    }
                                    self?.delegate?.success(data: subReddits, last: lastElement)
            },
                                  errorHandler: { [weak self] error in
                                    self?.delegate?.error(error: error)
        })
    }
}

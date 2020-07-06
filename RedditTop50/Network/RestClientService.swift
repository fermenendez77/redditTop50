//
//  RestClientService.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

class RestClientService {
    
    var urlBase: String
    var urlSession: URLSession = URLSession(configuration: .default)
    
    
    init(urlBase : String) {
        self.urlBase = urlBase
    }
   
    func dataRequest<T>(endpoint: String,
                        queryItems: [URLQueryItem],
                        returnType: T.Type,
                        completionHandler: @escaping (T) -> Void,
                        errorHandler: @escaping (ErrorData) -> Void) where T : Decodable {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.urlBase
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data else {
                    DispatchQueue.main.async {
                        errorHandler(.networkingError)
                        
                    }
                    return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch {
                DispatchQueue.main.async {
                    errorHandler(.networkingError)
                }
            }
            
        }
        dataTask.resume()
    }
    
}

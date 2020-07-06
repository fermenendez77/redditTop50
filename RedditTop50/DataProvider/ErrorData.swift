//
//  ErrorData.swift
//  RedditTop50
//
//  Created by Fernando Menendez on 03/07/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

enum ErrorData : Error {
    
    case networkingError
    case badRequestError
    case badFormatError
}

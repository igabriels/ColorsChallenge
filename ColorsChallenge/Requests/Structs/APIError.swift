//
//  APIError.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 26/01/21.
//

import Foundation

struct APIError {
    var apiName: String = "Error"
    let code: String
    let message: String
    
    static let badRequest = APIError(code: "-1", message: "Bad request")
    static let badResponse = APIError(code: "-1", message: "Could not parse response")
}

extension Error {
    var code: Int {
        return (self as NSError).code
    }
}

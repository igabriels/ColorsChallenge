//
//  URLRequestConvertible.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 1/25/21.
//

import Foundation

protocol URLConstruction {
    var method: HTTPMethod { get }
    var baseUrlString: String { get }
    var path: String { get }
    var port: String? { get }
}

protocol URLRequestConvertible: URLConstruction {
    func asURLRequest() throws -> URLRequest
    func request(headers: [String: String]?) -> URLRequest
    func requestWithAuthorization(token: String?, headers: [String: String]?) -> URLRequest
}

extension URLRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest { return self }
}

extension URLRequestConvertible {

    
    var requestURL: URL {
        guard let baseURL = URL(string: "\(baseUrlString)\(port ?? "")\(path)") else {
            return URL(string: baseUrlString)!
        }
        
        return baseURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseUrlString: String {
        return ""
    }
    
    var port: String? {
        return nil
    }
    
    var path: String {
        return ""
    }

    func request(headers: [String: String]? = nil) -> URLRequest {
        return requestWithAuthorization(token: nil, headers: headers)
    }
    
    func requestWithAuthorization(token: String?, headers: [String: String]? = nil) -> URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

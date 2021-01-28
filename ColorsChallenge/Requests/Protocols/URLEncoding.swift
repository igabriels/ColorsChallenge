//
//  URLEncoding.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 1/25/21.
//

import Foundation

public typealias Parameters = [String: Any]

protocol ParametersEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) -> URLRequest
}

struct URLEncoding: ParametersEncoding {
    enum EncodingType {
        case methodDependent
        case url
        case httpBody
    }
    
    static var `default`: URLEncoding { return URLEncoding() }
    static var queryString: URLEncoding { return URLEncoding(encodingType: .url) }
    static var httpBody: URLEncoding { return URLEncoding(encodingType: .httpBody) }
    
    var encodingType: EncodingType
    
    init(encodingType: EncodingType = .methodDependent) {
        self.encodingType = encodingType
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) -> URLRequest {
        var urlRequest = try! urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        guard let url = urlRequest.url else {
            return urlRequest
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value as? String))
        }
        urlComponents?.queryItems = queryItems
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET"), shouldEncodeParametersInURL(for: method) {
            urlRequest.url = urlComponents?.url
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
            
            guard let queryItemsString = urlComponents?.percentEncodedQuery else {
                return urlRequest
            }
            
            urlRequest.httpBody = queryItemsString.data(using: .utf8, allowLossyConversion: false)
        }
        
        return urlRequest
    }
    
    private func shouldEncodeParametersInURL(for method: HTTPMethod) -> Bool {
        switch encodingType {
        case .url: return true
        case .httpBody: return false
        default: break
        }
        
        switch method {
        case .get, .put, .delete: return true
        default: return false
        }
    }
}

struct JSONEncoding: ParametersEncoding {
    static var `default`: JSONEncoding { return JSONEncoding() }
    static var prettyPrinted: JSONEncoding { return JSONEncoding(options: .prettyPrinted) }
    
    let options: JSONSerialization.WritingOptions
    
    init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) -> URLRequest {
        var urlRequest = try! urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
        } catch { }
        
        return urlRequest
    }
    
    func encode(_ urlRequest: URLRequestConvertible, withJSONObject jsonObject: Any? = nil) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let jsonObject = jsonObject else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
        } catch { }
        
        return urlRequest
    }
}

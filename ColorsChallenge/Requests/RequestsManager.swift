//
//  RequestsManager.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 26/01/21.
//

import Foundation

typealias Success = ((Data) -> Void)?
typealias Failure = ((APIError) -> Void)?

class RequestsManager {
    private static var defaultSession: URLSession =  {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        return URLSession(configuration: configuration)
    }()
    
    @discardableResult class func request(_ request: URLRequestConvertible, _ success: Success = nil, failure: Failure = nil) -> URLSessionDataTask? {
        guard let urlRequest = try? request.asURLRequest() else {
            failure?(APIError.badRequest)
            return nil
        }
        
        print(urlRequest)
        
        let sessionTask = RequestsManager.defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let d = data else {
                    failure?(APIError.badResponse)
                    return
                }
                
                if let e = error {
                    failure?(APIError(apiName: request.path, code: "\(e.code)", message: e.localizedDescription))
                } else {
                    success?(d)
                }
            }
        }
                
        sessionTask.resume()
                
        return sessionTask
    }
}

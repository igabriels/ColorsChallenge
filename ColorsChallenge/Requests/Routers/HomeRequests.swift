//
//  HomeRequests.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 26/01/21.
//

import Foundation

enum HomeRequests {
    case getColorsList
}

extension HomeRequests: URLRequestConvertible {
    var baseUrlString: String {
        return "https://solidmobileengineering.com/services/game01/test.php"
    }
    
    var method: HTTPMethod {
        switch self {
            case .getColorsList: return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return request()
    }
}

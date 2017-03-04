//
//  WebUtil.swift
//  HAIP
//
//  Created by Hemant Singh on 08/12/16.
//  Copyright © 2016 Hemant Singh. All rights reserved.
//

import UIKit
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://newsapi.org/v1"
    static var OAuthToken: String? = Constants.apiKey
    
    case GetNews([String: AnyObject])
    case Sources([String: AnyObject])
 
    var method: Alamofire.HTTPMethod {
        switch self {
        case .GetNews:
            return .get
        case .Sources:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .GetNews:
            return "/articles"
        case .Sources:
            return "/sources"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Router.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = Router.OAuthToken {
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
            print(token)
        }
        urlRequest.cachePolicy = .reloadRevalidatingCacheData
        print(urlRequest.url?.absoluteString ?? "nil url")
        switch self {
        case .Sources(let lang):
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: lang)
        case .GetNews(let parameters):
            print(parameters)
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: parameters)
        default:
            return urlRequest
        }
    }
}

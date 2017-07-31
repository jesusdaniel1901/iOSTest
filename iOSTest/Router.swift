//
//  Router.swift
//  iOSTest
//
//  Created by Jesus Garcia on 7/30/17.
//  Copyright © 2017 Jesus Garcia. All rights reserved.
//

import Foundation
import Alamofire
typealias JSONDictionary = [String: Any]

enum Router {
  
  private static let baseHostPath = "http://localhost:3000/api"
  private static let versionPath = "/v1"
  
  var baseURLPath: String {
    return "\(Router.baseHostPath)\(Router.versionPath)"
  }
  
  
  case getCounters()
  case createCounter(parameters: JSONDictionary)
  case deleteCounter(parameters: JSONDictionary)
  case incrementCounter(parameters: JSONDictionary)
  case decrementCounter(parameters: JSONDictionary)
  
}

extension Router {
  
  typealias HTTPMethod = Alamofire.HTTPMethod
  
  struct Request {
    let method: HTTPMethod
    let path: String
    let encoding: ParameterEncoding
    let parameters: JSONDictionary?
    
    init(method: HTTPMethod, path: String, parameters: JSONDictionary? = nil, encoding: ParameterEncoding = JSONEncoding.default) {
      self.method = method
      self.path = path
      self.encoding = encoding
      self.parameters = parameters
    }
  }
  
  var request: Request {
    switch self {
      
    case .getCounters():
      return Request(method: .get, path: "/counters")
      
    case .createCounter(let params):
      return Request(method: .post, path: "/counter",parameters: params,encoding: JSONEncoding.default)
      
    case .deleteCounter(let params):
      return Request(method: .delete, path: "/counter",parameters: params,encoding: JSONEncoding.default)
      
    case .incrementCounter(let params):
      return Request(method: .post, path: "/counter/inc",parameters: params,encoding: JSONEncoding.default)
      
    case .decrementCounter(let params):
      return Request(method: .post, path: "/counter/dec",parameters: params,encoding: JSONEncoding.default)
    }
  }
}

extension Router: URLRequestConvertible {
  
  func asURLRequest() throws -> URLRequest {
    let url = URL(string: baseURLPath)!
    var urlRequest = URLRequest(url: url.appendingPathComponent(request.path))
    urlRequest.httpMethod = request.method.rawValue
    
    
    return try request.encoding.encode(urlRequest, with: request.parameters)
  }
}


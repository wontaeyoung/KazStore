//
//  AFRouter.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import Foundation
import Alamofire

protocol AFRouter: URLRequestConvertible {
  
  var method: HTTPMethod { get }
  var baseURL: String { get }
  var path: String { get }
  var headers: HTTPHeaders { get }
  var parameters: Parameters? { get }
}

extension AFRouter {
  
  public func asURLRequest() throws -> URLRequest {
    let url: URL = try baseURL.asURL().appendingPathComponent(path)
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.headers = headers
    
    return try URLEncoding.default.encode(request, with: parameters)
  }
}

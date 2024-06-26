//
//  ItunesAPIRouter.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import Alamofire

enum ItunesAPIRouter: AFRouter {
  
  case app(query: String, limit: Int, offset: Int)
  
  var method: HTTPMethod {
    switch self {
      case .app:
        return .get
    }
  }
  
  var baseURL: String {
    return "https://itunes.apple.com"
  }
  
  var path: String {
    switch self {
      case .app:
        return "search"
    }
  }
  
  var headers: HTTPHeaders {
    return []
  }
  
  var parameters: Parameters? {
    switch self {
      case let .app(query, limit, offset):
        return [
          ParameterKey.term.key: query,
          ParameterKey.limit.key: "\(limit)",
          ParameterKey.offset.key: "\(offset)",
          ParameterKey.country.key: country,
          ParameterKey.entity.key: entity
        ]
    }
  }
  
  var country: String {
    return "kr"
  }
  
  var entity: String {
    switch self {
      case .app:
        return "software"
    }
  }
  
  enum ParameterKey: String {
    case term
    case limit
    case offset
    case country
    case entity
    
    var key: String {
      return self.rawValue
    }
  }
}

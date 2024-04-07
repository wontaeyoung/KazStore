//
//  NetworkService.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import Foundation
import RxSwift
import RxAlamofire

final class NetworkService {
  
  func callRequest<T: Decodable>(router: AFRouter) -> Single<T> {
    return request(router)
      .data()
      .decode(type: T.self, decoder: JSONDecoder())
      .asSingle()
  }
}

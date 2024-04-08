//
//  AppRepository.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import RxSwift

final class AppRepository {
  
  private let networkService: NetworkService
  
  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  func fetch(query: String, offset: Int) -> Single<[App]> {
    let router: ItunesAPIRouter = .app(query: query, limit: BusinessValue.ituensAPICallLimit, offset: offset)
    let response: Single<AppResponse> = networkService.callRequest(router: router)
    
    return response
      .map { $0.results }
  }
}

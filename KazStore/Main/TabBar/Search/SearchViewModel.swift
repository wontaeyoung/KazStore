//
//  SearchViewModel.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import RxSwift
import RxCocoa

final class SearchViewModel: ViewModel {
  
  // MARK: - I / O
  struct Input {
    let searchEvent: PublishRelay<String>
  }
  
  struct Output {
    let apps: Driver<[App]>
  }
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  weak var coordinator: SearchCoordinator?
  private let appRepository: AppRepository
  
  // MARK: - Initializer
  init(appRepository: AppRepository) {
    self.appRepository = appRepository
  }
  
  // MARK: - Method
  func transform(input: Input) -> Output {
    
    let apps = BehaviorRelay<[App]>(value: [])
    
    input.searchEvent
      .thread(.global)
      .withUnretained(self)
      .flatMap { owner, query in
        return owner.appRepository.fetch(query: query)
          .catch {
            LogManager.shared.log(with: $0, to: .network)
            owner.coordinator?.showErrorAlert(error: $0)
            return .just([])
          }
      }
      .bind(to: apps)
      .disposed(by: disposeBag)
    
    return Output(apps: apps.asDriver())
  }
}


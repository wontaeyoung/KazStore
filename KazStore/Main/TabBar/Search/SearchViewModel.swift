//
//  SearchViewModel.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModel {
  
  // MARK: - I / O
  struct Input {
    let searchEvent: PublishRelay<String>
    let downloadTapEvent: PublishRelay<URL?>
  }
  
  struct Output {
    let apps: Driver<[App]>
    let searchCompleted: Driver<Void>
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
    let searchCompleted = PublishRelay<Void>()
    
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
      .do(onNext: { _ in
        searchCompleted.accept(())
      })
      .bind(to: apps)
      .disposed(by: disposeBag)
    
    input.downloadTapEvent
      .flatMap { url -> Observable<URL> in
        guard let url else { return Observable.error(SearchError.invalidDownloadURL) }
        
        return .just(url)
      }
      .thread(.main)
      .subscribe(with: self, onNext: { owner, url in
        owner.coordinator?.showDownloadWebView(url: url)
      }, onError: { owner, error in
        owner.coordinator?.showErrorAlert(error: error)
      })
      .disposed(by: disposeBag)
    
    return Output(
      apps: apps.asDriver(),
      searchCompleted: searchCompleted.asDriver(onErrorJustReturn: ())
    )
  }
  
  private func fakeDownload() -> Single<Void> {
    return Observable.just(())
      .delay(.seconds(3), scheduler: MainScheduler.instance)
      .asSingle()
  }
}

enum SearchError: AppError {
  case invalidDownloadURL
  
  var logDescription: String {
    switch self {
      case .invalidDownloadURL:
        return "다운로드 URL 변환 실패"
    }
  }
  
  var alertDescription: String {
    switch self {
      case .invalidDownloadURL:
        return "다운로드 주소가 등록되어있지 않은 앱이에요."
    }
  }
}

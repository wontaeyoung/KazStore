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
    let searchPaginationEvent: PublishRelay<Void>
    let downloadTapEvent: PublishRelay<URL?>
    let appCellTapEvent: PublishRelay<App>
  }
  
  struct Output {
    let apps: Driver<[App]>
    let searchCompleted: Driver<Void>
  }
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  weak var coordinator: SearchCoordinator?
  private var apiContainer = APIContainer()
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
      .do(onNext: { owner, _ in
        owner.apiContainer.resetPage()
      })
      .flatMap { owner, query in
        return owner.requestApps(query: query)
      }
      .do(onNext: { _ in
        searchCompleted.accept(())
      })
      .bind(to: apps)
      .disposed(by: disposeBag)
    
    input.searchPaginationEvent
      .withLatestFrom(input.searchEvent)
      .thread(.global)
      .withUnretained(self)
      .flatMap { owner, query in
        return owner.requestApps(query: query)
          .map { newApps in
            return apps.value + newApps
          }
      }
      .bind(to: apps)
      .disposed(by: disposeBag)
    
    input.downloadTapEvent
      .flatMap { url -> Observable<URL> in
        guard let url else {
          return Observable.error(SearchError.invalidDownloadURL)
        }
        
        return .just(url)
      }
      .thread(.main)
      .subscribe(with: self, onNext: { owner, url in
        owner.coordinator?.showDownloadWebView(url: url)
      }, onError: { owner, error in
        owner.coordinator?.showErrorAlert(error: error)
      })
      .disposed(by: disposeBag)
    
    input.appCellTapEvent
      .bind(with: self) { owner, app in
        owner.coordinator?.showSearchDetailView(app: app)
      }
      .disposed(by: disposeBag)
    
    return Output(
      apps: apps.asDriver(),
      searchCompleted: searchCompleted.asDriver(onErrorJustReturn: ())
    )
  }
  
  private func requestApps(query: String) -> Single<[App]> {
    return appRepository.fetch(query: query, offset: apiContainer.offset)
      .do(onSuccess: { _ in
        self.apiContainer.increasePage()
      })
      .catch { error in
        LogManager.shared.log(with: error, to: .network)
        self.coordinator?.showErrorAlert(error: error)
        return .just([])
      }
  }
  
  private func fakeDownload() -> Single<Void> {
    return Observable.just(())
      .delay(.seconds(3), scheduler: MainScheduler.instance)
      .asSingle()
  }
}

extension SearchViewModel {
  struct APIContainer {
    let limit: Int = BusinessValue.ituensAPICallLimit
    var page: Int = 0
    
    var offset: Int {
      return limit * page
    }
    
    mutating func increasePage() {
      page += 1
    }
    
    mutating func resetPage() {
      page = 0
    }
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

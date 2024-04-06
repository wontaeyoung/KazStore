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
    
  }
  
  struct Output {
    
  }
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  weak var coordinator: SearchCoordinator?
  
  // MARK: - Method
  func transform(input: Input) -> Output {
    
    return Output()
  }
}


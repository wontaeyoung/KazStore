//
//  SearchDetailViewModel.swift
//  KazStore
//
//  Created by 원태영 on 4/8/24.
//

import RxSwift
import RxRelay

final class SearchDetailViewModel: ViewModel {
  
  // MARK: - I / O
  struct Input {
    
  }
  
  struct Output {
    
  }
  
  var input = Input()
  var output = Output()
  
  // MARK: - Property
  let disposeBag = DisposeBag()
  weak var coordinator: SearchCoordinator?
  
  // MARK: - Method
  func transform(input: Input) -> Output {
    
    return Output()
  }
}

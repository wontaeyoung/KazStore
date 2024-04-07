//
//  SearchViewController.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: RxBaseViewController, ViewModelController {
  
  // MARK: - UI
  private let searchField = KSTextField(placeholder: "앱 이름", style: .search)
  
  // MARK: - Property
  let viewModel: SearchViewModel
  
  // MARK: - Initializer
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(searchField)
  }
  
  override func setConstraint() {
    searchField.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalTo(view).inset(20)
      make.height.equalTo(35)
    }
  }
  
  override func bind() {
    let input = SearchViewModel.Input(searchEvent: .init())
    let output = viewModel.transform(input: input)
    
    output.apps
      .drive(with: self) { owner, apps in
        dump(apps)
      }
      .disposed(by: disposeBag)
    
    searchField.rx.controlEvent(.editingDidEndOnExit)
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .withLatestFrom(searchField.rx.text.orEmpty)
      .distinctUntilChanged()
      .bind(to: input.searchEvent)
      .disposed(by: disposeBag)
  }
  
  // MARK: - Method
  
}

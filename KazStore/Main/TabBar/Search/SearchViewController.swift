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
  private lazy var searchResultTableView = UITableView().configured {
    $0.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
    $0.keyboardDismissMode = .onDrag
    $0.rowHeight = 80
    $0.separatorStyle = .none
  }
  
  // MARK: - Property
  let viewModel: SearchViewModel
  
  // MARK: - Initializer
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(searchField, searchResultTableView)
  }
  
  override func setConstraint() {
    searchField.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalTo(view).inset(20)
      make.height.equalTo(35)
    }
    
    searchResultTableView.snp.makeConstraints { make in
      make.top.equalTo(searchField.snp.bottom)
      make.horizontalEdges.equalTo(view)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  override func bind() {
    let input = SearchViewModel.Input(
      searchEvent: .init(),
      downloadTapEvent: .init()
    )
    let output = viewModel.transform(input: input)
    
    output.apps
      .drive(searchResultTableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { row, element, cell in
        
        cell.updateUI(with: element) {
          input.downloadTapEvent.accept(element.downloadURL)
        }
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

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
import Toast

final class SearchViewController: RxBaseViewController, ViewModelController {
  
  // MARK: - UI
  private let searchField = KSTextField(placeholder: "앱 이름", style: .search)
  private lazy var searchResultTableView = UITableView().configured {
    $0.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
    $0.keyboardDismissMode = .onDrag
    $0.rowHeight = 80
    $0.separatorStyle = .none
  }
  
  // MARK: - Observable
  private let isSearching = BehaviorRelay<Bool>(value: false)
  private let searchPaginationEvent = PublishRelay<Void>()
  
  // MARK: - Property
  let viewModel: SearchViewModel
  
  // MARK: - Initializer
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func viewDidLayoutSubviews() {
    searchField.snp.makeConstraints { make in
      make.width.equalTo(view)
      make.height.equalTo(35)
    }
  }
  
  override func setHierarchy() {
    view.addSubviews(searchField, searchResultTableView)
  }
  
  override func setConstraint() {
    searchResultTableView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  override func setAttribute() {
    navigationItem.titleView = searchField
  }
  
  override func bind() {
    let input = SearchViewModel.Input(
      searchEvent: .init(),
      searchPaginationEvent: searchPaginationEvent,
      downloadTapEvent: .init(),
      appCellTapEvent: .init()
    )
    
    let output = viewModel.transform(input: input)
    
    output.apps
      .drive(searchResultTableView.rx.items(cellIdentifier: SearchTableCell.identifier, cellType: SearchTableCell.self)) { row, element, cell in
        
        cell.updateUI(with: element) {
          input.downloadTapEvent.accept(element.downloadURL)
        }
      }
      .disposed(by: disposeBag)
    
    output.searchCompleted
      .do(onNext: { _ in
        self.searchResultTableView.setContentOffset(.zero, animated: false)
      })
      .map { false }
      .drive(isSearching)
      .disposed(by: disposeBag)
    
    searchField.rx.controlEvent(.editingDidEndOnExit)
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .withLatestFrom(searchField.rx.text.orEmpty)
      .distinctUntilChanged()
      .filter { !$0.isEmpty }
      .bind(with: self, onNext: { owner, query in
        owner.isSearching.accept(true)
        input.searchEvent.accept(query)
      })
      .disposed(by: disposeBag)
    
    isSearching
      .bind(with: self) { owner, isSearching in
        owner.toggleLoadingIndicator(isOn: isSearching)
      }
      .disposed(by: disposeBag)
    
    searchResultTableView.rx.itemSelected
      .bind(with: self) { owner, indexPath in
        owner.searchResultTableView.deselectRow(at: indexPath, animated: true)
      }
      .disposed(by: disposeBag)
    
    searchResultTableView.rx.modelSelected(App.self)
      .bind(to: input.appCellTapEvent)
      .disposed(by: disposeBag)
    
    searchResultTableView.rx.contentOffset
      .throttle(.seconds(2), scheduler: MainScheduler.instance)
      .withUnretained(self)
      .map { owner, offset in
        return owner.reachedBotton(offset: offset)
      }
      .filter { $0 }
      .flatMap { _ in Observable<Void>.just(()) }
      .debug(trimOutput: true)
      .bind(to: searchPaginationEvent)
      .disposed(by: disposeBag)
  }
  
  // MARK: - Method
  private func toggleLoadingIndicator(isOn: Bool) {
    if isOn {
      view.makeToastActivity(.center)
    } else {
      view.hideToastActivity()
    }
  }
  
  private func reachedBotton(offset: CGPoint) -> Bool {
    let tableViewHeight = searchResultTableView.frame.size.height
    let contentHeight = searchResultTableView.contentSize.height
    let threshold = max(contentHeight - tableViewHeight - 100, 0)
    
    return offset.y > threshold
  }
}

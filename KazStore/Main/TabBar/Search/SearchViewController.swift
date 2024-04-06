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
  
  
  // MARK: - Property
  let viewModel: SearchViewModel
  
  // MARK: - Initializer
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    
  }
  
  override func setConstraint() {
    
  }
  
  override func bind() {
      
  }
  
  // MARK: - Method
  
}

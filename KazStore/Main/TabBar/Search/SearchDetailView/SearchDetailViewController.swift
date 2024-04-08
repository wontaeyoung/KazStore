//
//  SearchDetailViewController.swift
//  KazStore
//
//  Created by 원태영 on 4/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchDetailViewController: RxBaseViewController, ViewModelController {
  
  // MARK: - UI
  
  
  // MARK: - Property
  let viewModel: SearchDetailViewModel
  
  // MARK: - Initializer
  init(viewModel: SearchDetailViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    
  }
  
  override func setConstraint() {
    
  }
  
  override func setAttribute() {
    
  }
  
  override func bind() {
    
  }
  
  // MARK: - Method
  
}

//
//  SearchCoordinator.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

final class SearchCoordinator: Coordinator {
  
  weak var delegate: CoordinatorDelegate?
  weak var tabBarDelegate: TabBarDelegate?
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator]
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.childCoordinators = []
  }
  
  func start() {
    
  }
}

extension SearchCoordinator {
  
}

//
//  AppCoordinator.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

final class AppCoordinator: Coordinator {
  
  weak var delegate: CoordinatorDelegate?
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator]
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.childCoordinators = []
  }
  
  func start() {
    connectMainTabBarFlow()
  }
}

extension AppCoordinator {
  
  private func connectMainTabBarFlow() {
    let mainTabBarCoordinator = MainTabBarCoordinator(navigationController)
    mainTabBarCoordinator.delegate = self
    mainTabBarCoordinator.start()
    self.addChild(mainTabBarCoordinator)
  }
}

extension AppCoordinator: CoordinatorDelegate {
  func coordinatorDidEnd(_ childCoordinator: Coordinator) { }
}


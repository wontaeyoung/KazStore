//
//  SceneDelegate.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private var coordinator: AppCoordinator?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let rootNavigationVC = UINavigationController()
      .navigationBarHidden()
    
    coordinator = AppCoordinator(rootNavigationVC)
    
    window = UIWindow(windowScene: scene)
    window?.rootViewController = rootNavigationVC
    window?.makeKeyAndVisible()
    
    coordinator?.start()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    
  }
}

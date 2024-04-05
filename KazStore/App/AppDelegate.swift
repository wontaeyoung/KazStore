//
//  AppDelegate.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setGlobalNavigationBarAppearance()
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
  }
  
  private func setGlobalNavigationBarAppearance() {
    
    UINavigationBar.appearance().configure {
      let appearance = UINavigationBarAppearance().configured {
        $0.titleTextAttributes = [.foregroundColor: KSAsset.Color.primary]
        $0.largeTitleTextAttributes = [.foregroundColor: KSAsset.Color.primary]
      }
      
      $0.standardAppearance = appearance
      $0.compactAppearance = appearance
      $0.scrollEdgeAppearance = appearance
      $0.compactScrollEdgeAppearance = appearance
    }
  }
}

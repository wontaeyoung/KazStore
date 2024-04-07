//
//  AppDelegate.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit
import Toast

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setGlobalNavigationBarAppearance()
    setGlobalToastStyle()
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
        $0.backgroundColor = KSAsset.Color.background
        $0.titleTextAttributes = [.foregroundColor: KSAsset.Color.primary]
        $0.largeTitleTextAttributes = [.foregroundColor: KSAsset.Color.primary]
      }
      
      $0.standardAppearance = appearance
      $0.compactAppearance = appearance
      $0.scrollEdgeAppearance = appearance
      $0.compactScrollEdgeAppearance = appearance
    }
  }
  
  private func setGlobalToastStyle() {
    ToastManager.shared.style = ToastStyle().applied {
      $0.backgroundColor = KSAsset.Color.lightGrayBackground
      $0.messageColor = KSAsset.Color.darkGray
      $0.messageFont = KSAsset.Font.ksToastMessage
      $0.titleColor = KSAsset.Color.secondary
      $0.titleFont = KSAsset.Font.ksToastTitle
      $0.titleAlignment = .center
      $0.activityBackgroundColor = .clear
      $0.activityIndicatorColor = KSAsset.Color.secondary
    }
  }
}

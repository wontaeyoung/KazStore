//
//  MainTabBarPage.swift
//  PhotoRamble
//
//  Created by 원태영 on 3/11/24.
//

import UIKit

enum MainTabBarPage: Int, CaseIterable {
  case today
  case game
  case app
  case arcade
  case search
  
  var index: Int {
    self.rawValue
  }
  
  var navigationTitle: String {
    switch self {
      case .today:
        return "투데이"
      case .game:
        return "게임"
      case .app:
        return "앱"
      case .arcade:
        return "아케이드"
      case .search:
        return "검색"
    }
  }
  
  var title: String {
    switch self {
      case .today:
        return "투데이"
      case .game:
        return "게임"
      case .app:
        return "앱"
      case .arcade:
        return "아케이드"
      case .search:
        return "검색"
    }
  }
  
  var icon: UIImage? {
    switch self {
      case .today:
        return KSAsset.Symbol.todayTabIcon
      case .game:
        return KSAsset.Symbol.gameTabIcon
      case .app:
        return KSAsset.Symbol.appTabIcon
      case .arcade:
        return KSAsset.Symbol.arcadeTabIcon
      case .search:
        return KSAsset.Symbol.searchTabIcon
    }
  }
  
  var selectedIcon: UIImage? {
    switch self {
      case .today:
        return KSAsset.Symbol.todaySelectedTabIcon
      case .game:
        return KSAsset.Symbol.gameSelectedTabIcon
      case .app:
        return KSAsset.Symbol.appSelectedTabIcon
      case .arcade:
        return KSAsset.Symbol.arcadeSelectedTabIcon
      case .search:
        return KSAsset.Symbol.searchSelectedTabIcon
    }
  }
  
  var tabBarItem: UITabBarItem {
    return UITabBarItem(
      title: title,
      image: icon,
      selectedImage: selectedIcon
    )
  }
}

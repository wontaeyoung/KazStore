//
//  KSAsset.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

enum KSAsset {
  
  enum Color {
    static let primary: UIColor = .init(hex: "#ED6D33")
    static let secondary: UIColor = .init(hex: "#F3B490")
    static let lightGrayBackground: UIColor = .init(hex: "#F2F2F6")
    static let lightGrayForeground: UIColor = .init(hex: "#BCBCBC")
    static let darkGray: UIColor = .init(hex: "#686868")
    static let background: UIColor = .background
    static let label: UIColor = .label
  }
  
  enum Font {
    private enum Name: String {
      case bold = "GmarketSansBold"
      case medium = "GmarketSansMedium"
      case light = "GmarketSansLight"
      
      var name: String {
        return self.rawValue
      }
    }
    
    private static func font(_ fontName: Name, size: CGFloat) -> UIFont {
      let coalesceWeight: UIFont.Weight
      
      switch fontName {
        case .bold:
          coalesceWeight = .bold
        case .medium:
          coalesceWeight = .medium
        case .light:
          coalesceWeight = .light
      }
      
      return UIFont(name: fontName.name, size: size) ?? .systemFont(ofSize: size, weight: coalesceWeight)
    }
    
    static let ksPrimaryButtonTitle: UIFont = font(.medium, size: 13)
    
    static let ksSearchField: UIFont = font(.medium, size: 19)
    static let ksPrimaryLabel: UIFont = font(.bold, size: 17)
    static let ksCaptionLabel: UIFont = font(.medium, size: 13)
    static let ksContentLabel: UIFont = font(.medium, size: 15)
    
    static let ksToastTitle: UIFont = font(.bold, size: 15)
    static let ksToastMessage: UIFont = font(.medium, size: 13)
  }
  
  enum Symbol {
    
    private enum SF: String {
      case docTextImage = "doc.text.image"
      case docTextImageFill = "doc.text.image.fill"
      case gamecontroller = "gamecontroller"
      case gamecontrollerFill = "gamecontroller.fill"
      case squareStack3dUp = "square.stack.3d.up"
      case squareStack3dUpFill = "square.stack.3d.up.fill"
      case arcadeStickConsole = "arcade.stick.console"
      case arcadeStickConsoleFill = "arcade.stick.console.fill"
      case magnifyingglass = "magnifyingglass"
    }
    
    private static func image(_ sf: SF) -> UIImage? {
      return UIImage(systemName: sf.rawValue)
    }
    
    static let todayTabIcon: UIImage? = image(.docTextImage)
    static let todaySelectedTabIcon: UIImage? = image(.docTextImageFill)
    static let gameTabIcon: UIImage? = image(.gamecontroller)
    static let gameSelectedTabIcon: UIImage? = image(.gamecontrollerFill)
    static let appTabIcon: UIImage? = image(.squareStack3dUp)
    static let appSelectedTabIcon: UIImage? = image(.squareStack3dUpFill)
    static let arcadeTabIcon: UIImage? = image(.arcadeStickConsole)
    static let arcadeSelectedTabIcon: UIImage? = image(.arcadeStickConsoleFill)
    static let searchTabIcon: UIImage? = image(.magnifyingglass)
    static let searchSelectedTabIcon: UIImage? = image(.magnifyingglass)
  }
}

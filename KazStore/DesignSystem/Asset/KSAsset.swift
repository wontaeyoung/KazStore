//
//  KSAsset.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

enum KSAsset {
  
  enum Color {
    static let primary: UIColor = .init(hex: "#FFC94A")
    static let background: UIColor = .background
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
    
    static let ksPrimaryButtonTitle: UIFont = font(.bold, size: 19)
  }
  
  enum Symbol {
    
    private enum SF: String {
      case star = "star"
    }
    
    private static func image(_ sf: SF) -> UIImage? {
      return UIImage(systemName: sf.rawValue)
    }
  }
}

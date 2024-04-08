//
//  KSLabel.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

class KSLabel: UILabel {
  
  private let style: Style
  
  override var text: String? {
    didSet {
      if case .content = style {
        applyLineSpacing()
      }
    }
  }
  
  init(style: Style, title: String? = nil, alignment: NSTextAlignment = .natural, line: Int = 1) {
    self.style = style
    
    super.init(frame: .zero)
    
    self.configure {
      $0.text = title
      $0.textAlignment = alignment
      $0.numberOfLines = line
    }
    
    switch style { 
      case .primary:
        self.configure {
          $0.font = KSAsset.Font.ksPrimaryLabel
          $0.textColor = KSAsset.Color.label
        }
        
      case .caption:
        self.configure {
          $0.font = KSAsset.Font.ksCaptionLabel
          $0.textColor = KSAsset.Color.lightGrayForeground
        }
        
      case .content:
        self.configure {
          $0.font = KSAsset.Font.ksContentLabel
          $0.textColor = KSAsset.Color.label
        }
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension KSLabel {
  
  enum Style {
    case primary
    case caption
    case content
  }
  
  func applyLineSpacing() {
    guard let text = self.text else { return }
    
    let style = NSMutableParagraphStyle().configured {
      $0.lineSpacing = 10
    }
    
    self.attributedText = NSMutableAttributedString(string: text).configured {
      let range = NSRange(location: 0, length: $0.length)
      
      $0.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
      $0.addAttribute(NSAttributedString.Key.font, value: KSAsset.Font.ksPrimaryButtonTitle, range: range)
    }
  }
}

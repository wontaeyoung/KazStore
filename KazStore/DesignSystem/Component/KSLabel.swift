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
      if true {
        applyLineSpacing()
      }
    }
  }
  
  init(style: Style, title: String? = nil, alignment: NSTextAlignment = .natural) {
    self.style = style
    
    super.init(frame: .zero)
    
    self.text = title
    self.textAlignment = alignment
    
    switch style { }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension KSLabel {
  
  enum Style {
    
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


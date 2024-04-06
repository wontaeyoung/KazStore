//
//  KSTextField.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit
import SnapKit

final class KSTextField: UITextField {
  
  private let underLine = UIView().configured {
    $0.backgroundColor = KSAsset.Color.secondary
  }
  
  init(placeholder: String? = nil, style: Style) {
    super.init(frame: .zero)
    
    self.placeholder = placeholder
    self.borderStyle = .none
    self.autocapitalizationType = .none
    self.autocorrectionType = .no
    self.spellCheckingType = .no
    self.tintColor = KSAsset.Color.primary
    self.addSubview(underLine)
    
    switch style {
      case .search:
        self.font = KSAsset.Font.ksSearchField
        self.returnKeyType = .search
        self.leftView = UIImageView(image: KSAsset.Symbol.searchTabIcon)
        self.leftViewMode = .always
    }
    
    underLine.snp.makeConstraints { make in
      make.horizontalEdges.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(1)
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension KSTextField {
  enum Style {
    case search
  }
}

//
//  KSButton.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

final class KSButton: UIButton {
  
  init(style: Style, title: String? = nil, image: UIImage? = nil) {
    super.init(frame: .zero)
    
    self.configuration = style.configuration.applied {
      $0.title = title
      $0.image = image
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func title(_ title: String) {
    self.configuration?.title = title
  }
  
  func image(_ image: UIImage) {
    self.configuration?.image = image
  }
}

extension KSButton {
  
  enum Style {
    case primary
    case secondary
    case tertiary
    case tag
    case icon
    
    private static let primaryConfig: UIButton.Configuration = .filled().applied {
      
      $0.baseForegroundColor = .white
      $0.baseBackgroundColor = KSAsset.Color.primary
      $0.buttonSize = .large
      $0.cornerStyle = .medium
      $0.imagePadding = 6
      
      $0.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {
        return $0.applied { $0.font = KSAsset.Font.ksPrimaryButtonTitle }
      }
    }
    
    private static let secondaryConfig: UIButton.Configuration = .filled().applied {
      
      $0.baseForegroundColor = KSAsset.Color.primary
      $0.baseBackgroundColor = KSAsset.Color.primary
      $0.buttonSize = .large
      $0.cornerStyle = .medium
      $0.imagePadding = 6
      
      $0.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {
        return $0.applied { $0.font = KSAsset.Font.ksPrimaryButtonTitle }
      }
    }
    
    private static let tertiaryConfig: UIButton.Configuration = .plain().applied {
      
      $0.baseForegroundColor = KSAsset.Color.primary
      $0.buttonSize = .large
      
      $0.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {
        return $0.applied { $0.font = KSAsset.Font.ksPrimaryButtonTitle }
      }
    }
    
    private static let tagConfig: UIButton.Configuration = .filled().applied {
      
      $0.buttonSize = .mini
      $0.cornerStyle = .capsule
      
      $0.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {
        return $0.applied { $0.font = KSAsset.Font.ksPrimaryButtonTitle }
      }
    }
    
    private static let iconConfig: UIButton.Configuration = .filled().applied {
      
      $0.baseForegroundColor = KSAsset.Color.primary
      $0.baseBackgroundColor = KSAsset.Color.primary
      $0.buttonSize = .mini
      $0.cornerStyle = .capsule
    }
    
    var configuration: UIButton.Configuration {
      switch self {
        case .primary:
          return Style.primaryConfig
          
        case .secondary:
          return Style.secondaryConfig
          
        case .tertiary:
          return Style.tertiaryConfig
          
        case .tag:
          return Style.tagConfig
          
        case .icon:
          return Style.iconConfig
      }
    }
  }
}

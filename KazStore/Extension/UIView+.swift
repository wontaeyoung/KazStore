//
//  UIView+.swift
//  KazStore
//
//  Created by 원태영 on 4/5/24.
//

import UIKit

extension UIView {
  func addSubviews(_ view: UIView...) {
    view.forEach { self.addSubview($0) }
  }
}

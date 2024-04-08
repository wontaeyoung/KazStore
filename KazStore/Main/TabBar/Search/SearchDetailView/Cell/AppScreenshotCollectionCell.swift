//
//  AppScreenshotCollectionCell.swift
//  KazStore
//
//  Created by 원태영 on 4/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher
import CollectionViewPagingLayout

final class AppScreenshotCollectionCell: RxBaseCollectionViewCell {
  
  // MARK: - UI
  private let screenshotImageView = UIImageView().configured {
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 20
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    contentView.addSubviews(screenshotImageView)
  }
  
  override func setConstraint() {
    screenshotImageView.snp.makeConstraints { make in
      make.edges.equalTo(contentView)
    }
  }
 
  func updateUI(url: URL?) {
    screenshotImageView.kf.setImage(with: url)
  }
}

extension AppScreenshotCollectionCell: ScaleTransformView {
  var scaleOptions: ScaleTransformViewOptions {
    return .layout(.coverFlow)
  }
}

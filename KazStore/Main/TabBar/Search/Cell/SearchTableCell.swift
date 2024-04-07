//
//  SearchTableCell.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class SearchTableCell: RxBaseTableViewCell {
  
  // MARK: - UI
  private let appIconImageView = UIImageView().configured {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 10
  }
  private let appNameLabel = KSLabel(style: .primary)
  private let downloadButton = KSButton(style: .tag, title: "받기")
  
  private var downloadEvent: (() -> Void)?
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    contentView.addSubviews(appIconImageView, appNameLabel, downloadButton)
  }
  
  override func setConstraint() {
    appIconImageView.snp.makeConstraints { make in
      make.leading.equalTo(contentView).inset(10)
      make.centerY.equalTo(contentView)
      make.size.equalTo(50)
    }
    
    appNameLabel.snp.makeConstraints { make in
      make.leading.equalTo(appIconImageView.snp.trailing).offset(10)
      make.centerY.equalTo(contentView)
      make.trailing.equalTo(downloadButton.snp.leading).offset(-10)
      make.height.equalTo(appIconImageView)
    }
    
    downloadButton.snp.makeConstraints { make in
      make.trailing.equalTo(contentView).inset(10)
      make.centerY.equalTo(contentView)
      make.width.equalTo(80)
    }
  }
  
  override func bind() {
    downloadButton.rx.tap
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .bind(with: self) { owner, _ in
        owner.downloadEvent?()
      }
      .disposed(by: disposeBag)
  }
  
  func updateUI(with app: App, downloadEvent: @escaping () -> Void) {
    appIconImageView.kf.setImage(with: app.appIconURL)
    appNameLabel.text = app.trackName
    self.downloadEvent = downloadEvent
  }
}

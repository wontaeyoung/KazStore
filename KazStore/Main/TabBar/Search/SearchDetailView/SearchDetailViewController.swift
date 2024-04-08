//
//  SearchDetailViewController.swift
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

final class SearchDetailViewController: RxBaseViewController, ViewModelController {
  
  // MARK: - UI
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  
  private let appIconImageView = UIImageView().configured {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 10
    $0.layer.borderColor = KSAsset.Color.lightGrayBackground.cgColor
  }
  
  private let appNameLabel = KSLabel(style: .primary)
  private let developerNameLabel = KSLabel(style: .caption)
  private let downloadButton = KSButton(style: .tag, title: "받기")
  
  private let releaseTitleLabel = KSLabel(style: .primary, title: "새로운 소식")
  private let releaseVersionLabel = KSLabel(style: .caption)
  private let releaseIntroductionLabel = KSLabel(style: .content, line: 0)
  
  private let layout = CollectionViewPagingLayout()
  private lazy var screenshotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).configured {
    $0.isPagingEnabled = true
    $0.register(AppScreenshotCollectionCell.self, forCellWithReuseIdentifier: AppScreenshotCollectionCell.identifier)
    $0.showsHorizontalScrollIndicator = false
  }
  
  private let appDescriptionTitleLabel = KSLabel(style: .primary, title: "앱 소개")
  private let appDescriptionContentLabel = KSLabel(style: .content, line: 0)
  
  // MARK: - Property
  let viewModel: SearchDetailViewModel
  private let app: App
  
  // MARK: - Initializer
  init(viewModel: SearchDetailViewModel, app: App) {
    self.viewModel = viewModel
    self.app = app
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(scrollView)
    
    scrollView.addSubviews(contentView)
    
    contentView.addSubviews(
      appIconImageView,
      appNameLabel,
      developerNameLabel,
      downloadButton,
      releaseTitleLabel,
      releaseVersionLabel,
      releaseIntroductionLabel,
      screenshotCollectionView,
      appDescriptionTitleLabel,
      appDescriptionContentLabel
    )
  }
  
  override func setConstraint() {
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints { make in
      make.verticalEdges.equalTo(scrollView)
      make.width.equalTo(scrollView).inset(20)
      make.centerX.equalTo(scrollView)
    }
    
    appIconImageView.snp.makeConstraints { make in
      make.size.equalTo(100)
      make.top.equalTo(contentView).inset(20)
      make.leading.equalTo(contentView)
    }
    
    appNameLabel.snp.makeConstraints { make in
      make.top.equalTo(contentView).inset(20)
      make.leading.equalTo(appIconImageView.snp.trailing).offset(20)
      make.trailing.equalTo(contentView).inset(20)
      make.bottom.equalTo(developerNameLabel.snp.top).offset(-10)
    }
    
    developerNameLabel.snp.makeConstraints { make in
      make.leading.equalTo(appIconImageView.snp.trailing).offset(20)
      make.bottom.equalTo(downloadButton.snp.top).offset(-10)
      make.trailing.equalTo(contentView).inset(20)
      make.height.equalTo(20)
    }
    
    downloadButton.snp.makeConstraints { make in
      make.leading.equalTo(appIconImageView.snp.trailing).offset(20)
      make.bottom.equalTo(appIconImageView)
      make.width.equalTo(60)
      make.height.equalTo(30)
    }
    
    releaseTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(appIconImageView.snp.bottom).offset(20)
      make.horizontalEdges.equalTo(contentView)
    }
    
    releaseVersionLabel.snp.makeConstraints { make in
      make.top.equalTo(releaseTitleLabel.snp.bottom).offset(10)
      make.horizontalEdges.equalTo(contentView)
    }
    
    releaseIntroductionLabel.snp.makeConstraints { make in
      make.top.equalTo(releaseVersionLabel.snp.bottom).offset(10)
      make.horizontalEdges.equalTo(contentView)
    }
    
    screenshotCollectionView.snp.makeConstraints { make in
      make.top.equalTo(releaseIntroductionLabel.snp.bottom)
      make.horizontalEdges.equalTo(view)
      make.height.equalTo(screenshotCollectionView.snp.width).multipliedBy(1.5)
    }
    
    appDescriptionTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(screenshotCollectionView.snp.bottom).offset(20)
      make.horizontalEdges.equalTo(contentView)
    }
    
    appDescriptionContentLabel.snp.makeConstraints { make in
      make.top.equalTo(appDescriptionTitleLabel.snp.bottom).offset(10)
      make.horizontalEdges.equalTo(contentView)
      make.bottom.equalTo(contentView).inset(20)
    }
  }
  
  override func setAttribute() {
    appIconImageView.kf.setImage(with: app.appIconURL)
    appNameLabel.text = app.trackName
    developerNameLabel.text = app.artistName
    releaseVersionLabel.text = app.version
    releaseIntroductionLabel.text = app.releaseNotes
    appDescriptionContentLabel.text = app.description
  }
  
  override func bind() {
    Observable.just(app.screenshotUrls)
      .map {
        $0.map { URL(string: $0) }
      }
      .bind(to: screenshotCollectionView.rx.items(cellIdentifier: AppScreenshotCollectionCell.identifier, cellType: AppScreenshotCollectionCell.self)) { item, element, cell in
        cell.updateUI(url: element)
      }
      .disposed(by: disposeBag)
  }
  
  // MARK: - Method
  
}

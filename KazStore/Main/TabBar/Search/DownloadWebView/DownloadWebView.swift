//
//  DownloadWebView.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

final class DownloadWebView: RxBaseViewController, WKNavigationDelegate {
  
  // MARK: - UI
  private let webView = WKWebView()
  private var isLoading: Bool = false
  
  // MARK: - Property
  private let url: URL
  
  // MARK: - Initializer
  init(url: URL) {
    self.url = url
    
    super.init()
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubviews(webView)
  }
  
  override func setAttribute() {
    if !isLoading {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  
  override func setConstraint() {
    webView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    isLoading = true
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    isLoading = false
  }
}

//
//  App.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import Foundation

struct AppResponse: Decodable {
  let resultCount: Int
  let results: [App]
}

struct App: DefaultValueProvidable {
  
  let id: UUID
  let screenshotUrls: [String]           /// 스크린샷 URL
  let artworkUrl512: String              /// 앱 아이콘
  let description: String                /// 앱 설명
  let artistId: Int                      /// 개발자 ID
  let artistName: String                 /// 개발자 이름
  let genres: [String]                   /// 장르
  let price: Double                      /// 가격, 무료는 0
  let trackId: Int                       /// 앱 ID
  let trackName: String                  /// 앱 이름
  let sellerName: String                 /// 판매자 이름
  let releaseDate: String                /// 첫 출시 날짜
  let releaseNotes: String               /// 최근 버전 설명
  let currentVersionReleaseDate: String  /// 최근 버전 업데이트 날짜
  let averageUserRating: Double          /// 평균 유저 평점
  let currency: String                   /// 통화 단위
  let minimumOsVersion: String           /// 기기 최소 지원 버전
  let trackViewUrl: String               /// 앱스토어 링크
  let trackContentRating: String         /// 이용 가능 연령
  let fileSizeBytes: String              /// 앱 용량
  let version: String                    /// 최근 버전
  let userRatingCount: Int               /// 리뷰 갯수
  let sellerUrl: String                  /// 판매자 사이트
  
  var appIconURL: URL? {
    return URL(string: artworkUrl512)
  }
  
  var downloadURL: URL? {
    return URL(string: trackViewUrl)
  }
  
  enum CodingKeys: CodingKey {
    case screenshotUrls
    case artworkUrl512
    case description
    case artistId
    case artistName
    case genres
    case price
    case trackId
    case trackName
    case sellerName
    case releaseDate
    case releaseNotes
    case currentVersionReleaseDate
    case averageUserRating
    case currency
    case minimumOsVersion
    case trackViewUrl
    case trackContentRating
    case fileSizeBytes
    case version
    case userRatingCount
    case sellerUrl
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = UUID()
    self.screenshotUrls = try container.decodeWithDefaultValue([String].self, forKey: .screenshotUrls)
    self.artworkUrl512 = try container.decodeWithDefaultValue(String.self, forKey: .artworkUrl512)
    self.description = try container.decodeWithDefaultValue(String.self, forKey: .description)
    self.artistId = try container.decodeWithDefaultValue(Int.self, forKey: .artistId)
    self.artistName = try container.decodeWithDefaultValue(String.self, forKey: .artistName)
    self.genres = try container.decodeWithDefaultValue([String].self, forKey: .genres)
    self.price = try container.decodeWithDefaultValue(Double.self, forKey: .price)
    self.trackId = try container.decodeWithDefaultValue(Int.self, forKey: .trackId)
    self.trackName = try container.decodeWithDefaultValue(String.self, forKey: .trackName)
    self.sellerName = try container.decodeWithDefaultValue(String.self, forKey: .sellerName)
    self.releaseDate = try container.decodeWithDefaultValue(String.self, forKey: .releaseDate)
    self.releaseNotes = try container.decodeWithDefaultValue(String.self, forKey: .releaseNotes)
    self.currentVersionReleaseDate = try container.decodeWithDefaultValue(String.self, forKey: .currentVersionReleaseDate)
    self.averageUserRating = try container.decodeWithDefaultValue(Double.self, forKey: .averageUserRating)
    self.currency = try container.decodeWithDefaultValue(String.self, forKey: .currency)
    self.minimumOsVersion = try container.decodeWithDefaultValue(String.self, forKey: .minimumOsVersion)
    self.trackViewUrl = try container.decodeWithDefaultValue(String.self, forKey: .trackViewUrl)
    self.trackContentRating = try container.decodeWithDefaultValue(String.self, forKey: .trackContentRating)
    self.fileSizeBytes = try container.decodeWithDefaultValue(String.self, forKey: .fileSizeBytes)
    self.version = try container.decodeWithDefaultValue(String.self, forKey: .version)
    self.userRatingCount = try container.decodeWithDefaultValue(Int.self, forKey: .userRatingCount)
    self.sellerUrl = try container.decodeWithDefaultValue(String.self, forKey: .sellerUrl)
  }
  
  init(id: UUID, screenshotUrls: [String], artworkUrl512: String, description: String, artistId: Int, artistName: String, genres: [String], price: Double, trackId: Int, trackName: String, sellerName: String, releaseDate: String, releaseNotes: String, currentVersionReleaseDate: String, averageUserRating: Double, currency: String, minimumOsVersion: String, trackViewUrl: String, trackContentRating: String, fileSizeBytes: String, version: String, userRatingCount: Int, sellerUrl: String) {
    self.id = id
    self.screenshotUrls = screenshotUrls
    self.artworkUrl512 = artworkUrl512
    self.description = description
    self.artistId = artistId
    self.artistName = artistName
    self.genres = genres
    self.price = price
    self.trackId = trackId
    self.trackName = trackName
    self.sellerName = sellerName
    self.releaseDate = releaseDate
    self.releaseNotes = releaseNotes
    self.currentVersionReleaseDate = currentVersionReleaseDate
    self.averageUserRating = averageUserRating
    self.currency = currency
    self.minimumOsVersion = minimumOsVersion
    self.trackViewUrl = trackViewUrl
    self.trackContentRating = trackContentRating
    self.fileSizeBytes = fileSizeBytes
    self.version = version
    self.userRatingCount = userRatingCount
    self.sellerUrl = sellerUrl
  }
  
  static var defaultValue: App {
    return App(
      id: UUID(),
      screenshotUrls: .defaultValue,
      artworkUrl512: .defaultValue,
      description: .defaultValue,
      artistId: .defaultValue,
      artistName: .defaultValue,
      genres: .defaultValue,
      price: .defaultValue,
      trackId: .defaultValue,
      trackName: .defaultValue,
      sellerName: .defaultValue,
      releaseDate: .defaultValue,
      releaseNotes: .defaultValue,
      currentVersionReleaseDate: .defaultValue,
      averageUserRating: .defaultValue,
      currency: .defaultValue,
      minimumOsVersion: .defaultValue,
      trackViewUrl: .defaultValue,
      trackContentRating: .defaultValue,
      fileSizeBytes: .defaultValue,
      version: .defaultValue,
      userRatingCount: .defaultValue,
      sellerUrl: .defaultValue
    )
  }
}

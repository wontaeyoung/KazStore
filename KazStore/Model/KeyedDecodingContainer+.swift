//
//  KeyedDecodingContainer+.swift
//  KazStore
//
//  Created by 원태영 on 4/7/24.
//

import Foundation

extension KeyedDecodingContainer {
  func decodeWithDefaultValue<T: DefaultValueProvidable>(
    _ type: T.Type,
    forKey key: KeyedDecodingContainer<K>.Key
  ) throws -> T {
    return try decodeIfPresent(type, forKey: key) ?? .defaultValue
  }
}

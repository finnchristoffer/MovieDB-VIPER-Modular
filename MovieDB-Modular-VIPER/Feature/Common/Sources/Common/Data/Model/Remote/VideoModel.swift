//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Foundation

// MARK: - CoinModel
public struct VideoResponseModel: Codable {
  let id: Int?
  public let results: [VideoModel]?
}

// MARK: - Result
public struct VideoModel: Codable {
  let iso639_1: ISO639_1?
  let iso3166_1: ISO3166_1?
  let name, key: String?
  let site: Site?
  let size: Int?
  let type: String?
  let official: Bool?
  let publishedAt, id: String?
  
  enum CodingKeys: String, CodingKey {
    case iso639_1 = "iso_639_1"
    case iso3166_1 = "iso_3166_1"
    case name, key, site, size, type, official
    case publishedAt = "published_at"
    case id
  }
}

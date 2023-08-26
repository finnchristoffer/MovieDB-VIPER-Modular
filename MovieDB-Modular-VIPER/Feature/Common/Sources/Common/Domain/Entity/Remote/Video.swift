//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Foundation

// MARK: - CoinModel
public struct VideoResponse: Equatable {
  public var id: Int?
  public var results: [Video]?
  
  public init(id: Int?, results: [Video]?) {
    self.id = id
    self.results = results
  }
}

// MARK: - Result
public struct Video: Equatable {
  public var iso639_1: ISO639_1?
  public var iso3166_1: ISO3166_1?
  public var name, key: String?
  public var site: Site?
  public var size: Int?
  public var type: String?
  public var official: Bool?
  public var publishedAt, id: String?
  
  public init(iso639_1: ISO639_1?,
              iso3166_1: ISO3166_1?,
              name: String?,
              key: String?,
              site: Site?,
              size: Int?,
              type: String?,
              official: Bool?,
              publishedAt: String?,
              id: String?) {
      self.iso639_1 = iso639_1
      self.iso3166_1 = iso3166_1
      self.name = name
      self.key = key
      self.site = site
      self.size = size
      self.type = type
      self.official = official
      self.publishedAt = publishedAt
      self.id = id
  }
}

public enum ISO3166_1: String, Codable {
  case us = "US"
}

public enum ISO639_1: String, Codable {
  case en = "en"
}

public enum Site: String, Codable {
  case vimeo = "Vimeo"
  case youTube = "YouTube"
}

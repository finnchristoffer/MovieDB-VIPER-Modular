//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Core

public struct VideoResponseToDomainMapper: Mapper {
  public typealias From = [VideoModel]
  public typealias To = [Video]
  
  public init() {}
  
  public func transform(from this: [VideoModel]) -> [Video] {
    return this.map { result in
      return Video(
        iso639_1: result.iso639_1,
        iso3166_1: result.iso3166_1,
        name: result.name,
        key: result.key,
        site: result.site,
        size: result.size,
        type: result.type,
        official: result.official,
        publishedAt: result.publishedAt,
        id: result.id
      )
    }
  }
}

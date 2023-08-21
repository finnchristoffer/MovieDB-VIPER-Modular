//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import Foundation
import ObjectMapper

extension MovieResponse: Mappable {
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    page <- map["page"]
    totalResults <- map["total_results"]
    totalPages <- map["total_pages"]
    results <- map["results"]
  }
}

extension Movie: Mappable {
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    voteCount <- map["vote_count"]
    id <- map["id"]
    originalLanguage <- map["original_language"]
    voteAverage <- map["vote_average"]
    genreIds <- map["genre_ids"]
    posterPath <- map["poster_path"]
    overview <- map["overview"]
    originalTitle <- map["original_title"]
    popularity <- map["popularity"]
    adult <- map["adult"]
    releaseDate <- map["release_date"]
    title <- map["title"]
    video <- map["video"]
    backdropPath <- map["backdrop_path"]
  }
}

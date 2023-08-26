//
//  Movie.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import Foundation

public struct MovieResponse: Equatable {
  public var totalResults: Int?
  public var results: [Movie]?
  public var totalPages: Int?
  public var page: Int?
  
  public init(totalResults: Int?, results: [Movie]?, totalPages: Int?, page: Int? ) {
    self.totalResults = totalResults
    self.results = results
    self.totalPages = totalPages
    self.page = page
  }
}

public struct Movie: Equatable {
  public var voteAverage: Double?
  public var genres: [Genre]?
  public var posterPath: String?
  public var popularity: Double?
  public var title: String?
  public var releaseDate: String?
  public var video: Bool?
  public var voteCount: Int?
  public var adult: Bool?
  public var originalTitle: String?
  public var originalLanguage: String?
  public var backdropPath: String?
  public var id: Int?
  public var overview: String?
  
  public init(voteAverage: Double?, genres: [Genre]?, posterPath: String?, popularity: Double?, title: String?, releaseDate: String?, video: Bool?, voteCount: Int?, adult: Bool?, originalTitle: String?, originalLanguage: String?, backdropPath: String?, id: Int?, overview: String? ) {
    self.voteAverage = voteAverage
    self.genres = genres
    self.posterPath = posterPath
    self.popularity = popularity
    self.title = title
    self.releaseDate = releaseDate
    self.video = video
    self.voteCount = voteCount
    self.adult = adult
    self.originalTitle = originalTitle
    self.originalLanguage = originalLanguage
    self.backdropPath = backdropPath
    self.id = id
    self.overview = overview
  }
}

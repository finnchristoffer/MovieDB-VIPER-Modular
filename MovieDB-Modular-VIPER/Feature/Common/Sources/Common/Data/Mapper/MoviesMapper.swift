//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import Core

public struct MovieResponseToDomainMapper: Mapper {
  public typealias From = MovieResponseModel
  public typealias To = MovieResponse
  
  public init() {}
  
  public func transform(from this: MovieResponseModel) -> MovieResponse {
    let movies = this.results?.map { movieModel in
      return Movie(
        voteAverage: movieModel.voteAverage,
        genres: mapGenres(from: movieModel.genres ?? []),
        posterPath: movieModel.posterPath,
        popularity: movieModel.popularity,
        title: movieModel.title,
        releaseDate: movieModel.releaseDate,
        video: movieModel.video,
        voteCount: movieModel.voteCount,
        adult: movieModel.adult,
        originalTitle: movieModel.originalTitle,
        originalLanguage: movieModel.originalLanguage,
        backdropPath: movieModel.backdropPath,
        id: movieModel.id,
        overview: movieModel.overview
      )
    }
    
    return MovieResponse(
      totalResults: this.totalResults,
      results: movies,
      totalPages: this.totalPages,
      page: this.page
    )
  }
  
  private func mapGenres(from genreModels: [GenreModel]) -> [Genre] {
    return genreModels.map { genreModel in
      return Genre(name: genreModel.name, id: genreModel.id)
    }
  }
}

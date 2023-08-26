//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Core

public struct MovieToDomainMapper: Mapper {
  public typealias From = MovieModel
  public typealias To = Movie
  
  public init() {}
  
  public func transform(from this: MovieModel) -> Movie {
    return Movie(
      voteAverage: this.voteAverage,
      genres: mapGenres(from: this.genres ?? []),
      posterPath: this.posterPath,
      popularity: this.popularity,
      title: this.title,
      releaseDate: this.releaseDate,
      video: this.video,
      voteCount: this.voteCount,
      adult: this.adult,
      originalTitle: this.originalTitle,
      originalLanguage: this.originalLanguage,
      backdropPath: this.backdropPath,
      id: this.id,
      overview: this.overview
    )
  }
  
  private func mapGenres(from genreModels: [GenreModel]) -> [Genre] {
    return genreModels.map { genreModel in
      return Genre(name: genreModel.name, id: genreModel.id)
    }
  }
}

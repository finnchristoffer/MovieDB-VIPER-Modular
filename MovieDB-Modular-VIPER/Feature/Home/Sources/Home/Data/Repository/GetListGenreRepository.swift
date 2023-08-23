//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import RxSwift
import Core
import Common

public struct GetListGenreRepository: Repository {
  public typealias Request = Any
  public typealias Response = [Genre]
  
  private let remoteDataSource: GetListGenreMovieRemoteDataSource
  private let mapper: GenreResponseToDomainMapper
  
  public init(
    remoteDataSource: GetListGenreMovieRemoteDataSource,
    mapper: GenreResponseToDomainMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Request?) -> Observable<[Genre]> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}

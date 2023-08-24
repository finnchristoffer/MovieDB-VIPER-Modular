//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import RxSwift
import Core
import Common

public struct GetListMovieRepository: Repository {
  public typealias Request = Int
  public typealias Response = MovieResponse
  
  private let remoteDataSource: GetListMovieRemoteDataSource
  private let mapper: MovieResponseToDomainMapper
  
  public init(
    remoteDataSource: GetListMovieRemoteDataSource,
    mapper: MovieResponseToDomainMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Int?) -> Observable<MovieResponse> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}

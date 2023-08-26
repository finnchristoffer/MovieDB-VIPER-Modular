//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import RxSwift
import RxCocoa
import Core
import Common

public struct GetTrailerMovieRepository: Repository {
  public typealias Request = Int
  public typealias Response = [Video]
  
  private let remoteDataSource: GetTrailerVideoDataSource
  private let mapper: VideoResponseToDomainMapper
  
  public init(
    remoteDataSource: GetTrailerVideoDataSource,
    mapper: VideoResponseToDomainMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Int?) -> Observable<[Video]> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}

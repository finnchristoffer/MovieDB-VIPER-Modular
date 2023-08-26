//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import RxSwift
import RxCocoa
import Core
import Common

public struct GetReviewMovieRepository: Repository {
  public typealias Request = Int
  public typealias Response = [Review]
  
  private let remoteDataSource: GetReviewMovieDataSource
  private let mapper: ReviewToDomainMapper
  
  public init(
    remoteDataSource: GetReviewMovieDataSource,
    mapper: ReviewToDomainMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Int?) -> Observable<[Review]> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}


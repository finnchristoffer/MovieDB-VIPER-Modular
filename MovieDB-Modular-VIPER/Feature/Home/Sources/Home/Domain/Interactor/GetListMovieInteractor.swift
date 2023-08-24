//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import Core
import RxSwift
import Common

public struct GetListMovieInteractor: UseCase {
  public typealias Request = Int
  public typealias Response = MovieResponse
  
  private let repository: GetListMovieRepository
  
  public init(repository: GetListMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Int?) -> Observable<MovieResponse> {
    return repository.execute(request: request)
  }
}

//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Core
import RxSwift
import RxCocoa
import Common

public struct GetMovieDetailInteractor: UseCase {
  public typealias Request = Int
  public typealias Response = Movie
  
  private let repository: GetMovieDetailRepository
  
  public init(repository: GetMovieDetailRepository) {
    self.repository = repository
  }
  
  public func execute(request: Int?) -> Observable<Movie> {
    return repository.execute(request: request)
  }
}

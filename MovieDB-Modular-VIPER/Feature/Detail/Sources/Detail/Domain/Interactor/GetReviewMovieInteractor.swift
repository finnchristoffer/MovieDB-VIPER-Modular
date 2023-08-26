//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Core
import RxSwift
import RxCocoa
import Common

public struct GetReviewMovieInteractor: UseCase {
  public typealias Request = Int
  public typealias Response = [Review]
  
  private let repository: GetReviewMovieRepository
  
  public init(repository: GetReviewMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Int?) -> Observable<[Review]> {
    return repository.execute(request: request)
  }
}

//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Core
import RxSwift
import Common

public struct GetListGenreMovieInteractor: UseCase {
  public typealias Request = Any
  public typealias Response = [Genre]
  
  private let repository: GetListGenreRepository
  
  public init(repository: GetListGenreRepository) {
    self.repository = repository
  }
  
  public func execute(request: Request?) -> Observable<[Genre]> {
    return repository.execute(request: request)
  }
}

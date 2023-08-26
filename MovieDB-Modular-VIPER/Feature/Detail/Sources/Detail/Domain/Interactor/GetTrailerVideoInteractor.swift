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

public struct GetTrailerVideoInteractor: UseCase {
  public typealias Request = Int
  public typealias Response = [Video]
  
  private let repository: GetTrailerMovieRepository
  
  public init(repository: GetTrailerMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Int?) -> Observable<[Video]> {
    return repository.execute(request: request)
  }
}

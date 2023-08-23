//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Core

public struct GenreResponseToDomainMapper: Mapper {
  public typealias From = [GenreModel]
  public typealias To = [Genre]
  
  public init() {}
  
  public func transform(from this: [GenreModel]) -> [Genre] {
    return this.map { result in
      return Genre(
        name: result.name,
        id: result.id
      )
    }
  }
}

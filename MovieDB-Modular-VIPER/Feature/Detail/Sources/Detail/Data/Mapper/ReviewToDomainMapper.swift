//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Core

public struct ReviewToDomainMapper: Mapper {
  public typealias From = [ReviewModel]
  public typealias To = [Review]
  
  public init() {}
  
  public func transform(from this: [ReviewModel]) -> [Review] {
    return this.map { result in
      return Review(
        author: result.author,
        authorDetails: mapAuthorDetails(from: result.authorDetails ?? AuthorDetailsModel(name: "", username: "", avatarPath: "", rating: 0)),
        content: result.content,
        createdAt: result.createdAt,
        id: result.id,
        updatedAt: result.updatedAt,
        url: result.url
      )
    }
  }
  
  private func mapAuthorDetails(from authorDetailsModel: AuthorDetailsModel) -> AuthorDetails {
      return AuthorDetails(
          name: authorDetailsModel.name,
          username: authorDetailsModel.username,
          avatarPath: authorDetailsModel.avatarPath,
          rating: authorDetailsModel.rating
      )
  }
}

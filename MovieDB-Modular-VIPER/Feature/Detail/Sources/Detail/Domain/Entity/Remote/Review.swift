//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

// MARK: - ReviewResponseModel
public struct ReviewResponse: Equatable {
  public var id, page: Int?
  public var results: [Review]?
  public var totalPages, totalResults: Int?
  
  public init(id: Int?, page: Int?, result: [Review]?, totalPages: Int?, totalResults: Int?) {
    self.id = id
    self.page = page
    self.results = result
    self.totalPages = totalPages
    self.totalResults = totalResults
  }
}

// MARK: - Result
public struct Review: Equatable {
  public var author: String?
  public var authorDetails: AuthorDetails?
  public var content, createdAt, id, updatedAt: String?
  public var url: String?
  
  public init(author: String?, authorDetails: AuthorDetails?, content: String?, createdAt: String?, id: String?, updatedAt: String?, url: String?) {
    self.author = author
    self.authorDetails = authorDetails
    self.content = content
    self.createdAt = createdAt
    self.id = id
    self.updatedAt = updatedAt
    self.url = url
  }
}

// MARK: - AuthorDetails
public struct AuthorDetails: Equatable {
  public var name, username: String?
  public var avatarPath: String?
  public var rating: Int?
  
  public init(name: String? = nil, username: String? = nil, avatarPath: String? = nil, rating: Int? = nil) {
    self.name = name
    self.username = username
    self.avatarPath = avatarPath
    self.rating = rating
  }
}


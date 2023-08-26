//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Foundation

// MARK: - ReviewResponseModel
public struct ReviewResponseModel: Codable {
  let id, page: Int?
  public let results: [ReviewModel]?
  let totalPages, totalResults: Int?
  
  enum CodingKeys: String, CodingKey {
    case id, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
public struct ReviewModel: Codable {
  let author: String?
  let authorDetails: AuthorDetailsModel?
  let content, createdAt, id, updatedAt: String?
  let url: String?
  
  enum CodingKeys: String, CodingKey {
    case author
    case authorDetails = "author_details"
    case content
    case createdAt = "created_at"
    case id
    case updatedAt = "updated_at"
    case url
  }
}

// MARK: - AuthorDetails
public struct AuthorDetailsModel: Codable {
  let name, username: String?
  let avatarPath: String?
  let rating: Int?
  
  enum CodingKeys: String, CodingKey {
    case name, username
    case avatarPath = "avatar_path"
    case rating
  }
}

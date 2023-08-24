//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Foundation

// MARK: - GenreResponse
public struct GenreResponseModel: Codable {
    public let genres: [GenreModel]?
}

// MARK: - Genre
public struct GenreModel: Codable {
    let id: Int?
    let name: String?
  
  enum CodingKeys: String, CodingKey {
    case name, id
  }
}

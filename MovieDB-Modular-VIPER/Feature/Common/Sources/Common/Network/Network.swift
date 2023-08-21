//
//  Network.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import Foundation

public struct API {
  static let baseURL = "https://api.themoviedb.org/3/"
  static let baseURLImage = "https://image.tmdb.org/t/p/original"
  static let apiKey = ""
}

public protocol Endpoint {
  var url: String { get }
}

public enum Endpoints {
  
  public enum Get: Endpoint {
    case genre
    case movie(id: Int)
    
    public var url: String {
      switch self {
      case .genre: return "\(API.baseURL)genre/movie/list"
      case .movie(let id): return "\(API.baseURL)movie/\(id)?api_key=\(API.apiKey)"
      }
    }
  }
}

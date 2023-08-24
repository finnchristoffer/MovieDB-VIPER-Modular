//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Foundation

public struct API {
  static let baseUrl = "https://api.themoviedb.org/3"
  public static let baseUrlImage = "https://image.tmdb.org/t/p/original"
  static let apiKey = "d8bf466e0e794e7f8499748928d9f491"
}

public protocol Endpoint {
  var url: String { get }
}

public enum Endpoints {
  
  public enum Get: Endpoint {
    case genre
    case listMovie(genre: Int)
    
    public var url: String {
      switch self {
      case .genre:
        return "\(API.baseUrl)/genre/movie/list?api_key=\(API.apiKey)"
      case .listMovie(let genre):
        return "\(API.baseUrl)/discover/movie?api_key=\(API.apiKey)&with_genres=\(genre)"
      }
    }
  }
}

//private var apiKeyValue: String {
//  get {
//    guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist") else {
//      fatalError("Couldn't find file 'TMDB-Info.plist'.")
//    }
//
//    let plist = NSDictionary(contentsOfFile: filePath)
//    guard let value = plist?.object(forKey: "API_KEY") as? String else {
//      fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
//    }
//
//    if (value.starts(with: "_")) {
//      fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
//    }
//
//    return value
//  }
//}


//
//  Genre+Mappable.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import Foundation
import ObjectMapper

extension Genre: Mappable {
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
  }
}

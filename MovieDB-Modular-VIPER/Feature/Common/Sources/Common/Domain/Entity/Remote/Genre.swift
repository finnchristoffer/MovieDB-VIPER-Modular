//
//  Genre.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import Foundation

public struct Genre {
  public var name: String?
  public var id: Int?
  
  public init(name: String?, id: Int? ) {
    self.name = name
    self.id = id
  }
}

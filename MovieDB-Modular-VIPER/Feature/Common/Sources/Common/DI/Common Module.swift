//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Swinject

public class CommonModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: Mapper
    container.register(GenreResponseToDomainMapper.self) { _ in
      GenreResponseToDomainMapper()
    }
    
    container.register(MovieResponseToDomainMapper.self) { _ in
      MovieResponseToDomainMapper()
    }
    
    return container
  }()
}


//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Swinject
import Common

public class HomeModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: - DataSource
    container.register(GetListGenreMovieRemoteDataSource.self) { _ in
      GetListGenreMovieRemoteDataSource()
    }
    
    // MARK: - Repository
    container.register(GetListGenreRepository.self) { resolver in
      GetListGenreRepository(
        remoteDataSource: resolver.resolve(GetListGenreMovieRemoteDataSource.self)!,
        mapper: CommonModule().container.resolve(GenreResponseToDomainMapper.self)!
      )
    }
    
    // MARK: - Interactor
    container.register(GetListGenreMovieInteractor.self) { resolver in
      GetListGenreMovieInteractor(repository: resolver.resolve(GetListGenreRepository.self)!)
    }
    
    // MARK: - Presenter
    container.register(HomePresenter.self) { resolver in
      HomePresenter(
        genreMovieInteractor: resolver.resolve(GetListGenreMovieInteractor.self)!
      )
    }
    
    // MARK: - ViewController
    container.register(HomeViewController.self) { resolver in
      let presenter = resolver.resolve(HomePresenter.self)!
      return HomeViewController(presenter: presenter)
    }
    
    return container
  }()
}

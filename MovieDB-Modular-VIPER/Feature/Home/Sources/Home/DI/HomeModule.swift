//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import Swinject
import Common
import UIKit

public class HomeModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: - UINavigationController
    container.register(UINavigationController.self) { _ in
        return UINavigationController()
    }
    
    // MARK: - DataSource
    container.register(GetListGenreMovieRemoteDataSource.self) { _ in
      GetListGenreMovieRemoteDataSource()
    }
    
    container.register(GetListMovieRemoteDataSource.self) { _ in
      GetListMovieRemoteDataSource()
    }
    
    // MARK: - Repository
    container.register(GetListGenreRepository.self) { resolver in
      GetListGenreRepository(
        remoteDataSource: resolver.resolve(GetListGenreMovieRemoteDataSource.self)!,
        mapper: CommonModule().container.resolve(GenreResponseToDomainMapper.self)!
      )
    }
    
    container.register(GetListMovieRepository.self) { resolver in
      GetListMovieRepository(
        remoteDataSource: resolver.resolve(GetListMovieRemoteDataSource.self)!,
        mapper: CommonModule().container.resolve(MovieResponseToDomainMapper.self)!
      )
    }
    
    // MARK: - Interactor
    container.register(GetListGenreMovieInteractor.self) { resolver in
      GetListGenreMovieInteractor(repository: resolver.resolve(GetListGenreRepository.self)!)
    }
    
    container.register(GetListMovieInteractor.self) { resolver in
      GetListMovieInteractor(repository: resolver.resolve(GetListMovieRepository.self)!)
    }
    
    // MARK: - Router
    container.register(HomeRouter.self) { _ in
      HomeRouter()
    }
    
    // MARK: - Presenter
    container.register(ListGenrePresenter.self) { resolver in
      ListGenrePresenter(
        homeRouter: resolver.resolve(HomeRouter.self)!,
        genreMovieInteractor: resolver.resolve(GetListGenreMovieInteractor.self)!
      )
    }
    
    container.register(ListMoviePresenter.self) { resolver in
      ListMoviePresenter(
        listMovieInteractor: resolver.resolve(GetListMovieInteractor.self)!
      )
    }
    
    // MARK: - ViewController
    container.register(ListGenreViewController.self) { resolver in
      let presenter = resolver.resolve(ListGenrePresenter.self)!
      return ListGenreViewController(presenter: presenter)
    }
    
    container.register(ListMovieViewController.self) { resolver in
      let presenter = resolver.resolve(ListMoviePresenter.self)!
      return ListMovieViewController(presenter: presenter)
    }
    
    return container
  }()
}

//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Swinject
import Common
import UIKit

public class DetailModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: - UINavigationController
    container.register(UINavigationController.self) { _ in
        return UINavigationController()
    }
    
    // MARK: Mapper
    container.register(ReviewToDomainMapper.self) { _ in
      ReviewToDomainMapper()
    }
    
    // MARK: - DataSource
    container.register(GetMovieDetailDataSource.self) { _ in
      GetMovieDetailDataSource()
    }
    
    container.register(GetTrailerVideoDataSource.self) { _ in
      GetTrailerVideoDataSource()
    }
    
    container.register(GetReviewMovieDataSource.self) { _ in
      GetReviewMovieDataSource()
    }
    
    // MARK: - Repository
    container.register(GetMovieDetailRepository.self) { resolver in
      GetMovieDetailRepository(
        remoteDataSource: resolver.resolve(GetMovieDetailDataSource.self)!,
        mapper: CommonModule().container.resolve(MovieToDomainMapper.self)!
      )
    }
    
    container.register(GetTrailerMovieRepository.self) { resolver in
      GetTrailerMovieRepository(
        remoteDataSource: resolver.resolve(GetTrailerVideoDataSource.self)!,
        mapper: CommonModule().container.resolve(VideoResponseToDomainMapper.self)!
      )
    }
    
    container.register(GetReviewMovieRepository.self) { resolver in
      GetReviewMovieRepository(
        remoteDataSource: resolver.resolve(GetReviewMovieDataSource.self)!,
        mapper: resolver.resolve(ReviewToDomainMapper.self)!
      )
    }
    
    // MARK: - Interactor
    container.register(GetMovieDetailInteractor.self) { resolver in
      GetMovieDetailInteractor(repository: resolver.resolve(GetMovieDetailRepository.self)!)
    }
    
    container.register(GetTrailerVideoInteractor.self) { resolver in
      GetTrailerVideoInteractor(repository: resolver.resolve(GetTrailerMovieRepository.self)!)
    }
    
    container.register(GetReviewMovieInteractor.self) { resolver in
      GetReviewMovieInteractor(repository: resolver.resolve(GetReviewMovieRepository.self)!)
    }
    
    // MARK: - Router
    container.register(DetailMovieRouter.self) { _ in
      DetailMovieRouter()
    }
    
    // MARK: - Presenter
    container.register(DetailMoviePresenter.self) { resolver in
      DetailMoviePresenter(
        detailMovieRouter: resolver.resolve(DetailMovieRouter.self)!,
        getMovieDetailInteractor: resolver.resolve(GetMovieDetailInteractor.self)!,
        getTrailerMovieInteractor: resolver.resolve(GetTrailerVideoInteractor.self)!,
        getReviewMovieInteractor: resolver.resolve(GetReviewMovieInteractor.self)!
      )
    }
    
    // MARK: - ViewController
    container.register(DetailMovieViewController.self) { resolver in
      let presenter = resolver.resolve(DetailMoviePresenter.self)!
      return DetailMovieViewController(presenter: presenter)
    }
    
    container.register(ReviewMovieViewController.self) { resolver in
      let presenter = resolver.resolve(DetailMoviePresenter.self)!
      return ReviewMovieViewController(presenter: presenter)
    }
    
    return container
  }()
}


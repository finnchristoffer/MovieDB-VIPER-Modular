//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import RxSwift
import RxCocoa
import Common
import UIKit

final class ListMoviePresenter {
  var listMovie = BehaviorRelay<[Movie]>(value: [])
  
  private let listMovieRouter: ListMovieRouterProtocol
  private let listMovieInteractor: GetListMovieInteractor
  
  private let disposeBag = DisposeBag()
  
  init(
    listMovieRouter: ListMovieRouter,
    listMovieInteractor: GetListMovieInteractor
  ) {
    self.listMovieRouter = listMovieRouter
    self.listMovieInteractor = listMovieInteractor
  }
  
  func fetchGenresMovie(genre: Int) {
    listMovieInteractor.execute(request: genre)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.listMovie.accept(movies.results ?? [])
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func didSelectMovie(with movieId: Int, from viewController: UIViewController) {
    listMovieRouter.navigateToDetailMovie(for: movieId, from: viewController)
  }
}

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
  
//  private let homeRouter: HomeRouterProtocol
  private let listMovieInteractor: GetListMovieInteractor
  
  private let disposeBag = DisposeBag()
  
  init(
//    homeRouter: HomeRouter,
    listMovieInteractor: GetListMovieInteractor
  ) {
//    self.homeRouter = homeRouter
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
  
//  func didSelectGenre(at index: Int, from viewController: UIViewController) {
//    let selectedGenre = genresMovie.value[index].id
//    homeRouter.navigateToGenreDetail(for: selectedGenre, from: viewController)
//  }
}


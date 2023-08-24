//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import RxSwift
import RxCocoa
import Common
import UIKit

final class ListGenrePresenter {
  var genresMovie = BehaviorRelay<[Genre]>(value: [])
  
  private let homeRouter: HomeRouterProtocol
  private let genreMovieInteractor: GetListGenreMovieInteractor
  
  private let disposeBag = DisposeBag()
  
  init(
    homeRouter: HomeRouter,
    genreMovieInteractor: GetListGenreMovieInteractor
  ) {
    self.homeRouter = homeRouter
    self.genreMovieInteractor = genreMovieInteractor
  }
  
  func fetchGenresMovie() {
    genreMovieInteractor.execute(request: nil)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] genres in
        self?.genresMovie.accept(genres)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func didSelectGenre(at index: Int, from viewController: UIViewController) {
    let selectedGenre = genresMovie.value[index].id
    homeRouter.navigateToGenreDetail(for: selectedGenre, from: viewController)
  }
}

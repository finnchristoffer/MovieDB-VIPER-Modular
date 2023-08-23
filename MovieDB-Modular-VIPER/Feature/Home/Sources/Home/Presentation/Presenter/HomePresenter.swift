//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 22/08/23.
//

import RxSwift
import RxCocoa
import Common

final class HomePresenter {
  var genresMovie = BehaviorRelay<[Genre]>(value: [])
  
  private let disposeBag = DisposeBag()
  private let genreMovieInteractor: GetListGenreMovieInteractor
  
  init(
    genreMovieInteractor: GetListGenreMovieInteractor
  ) {
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
}

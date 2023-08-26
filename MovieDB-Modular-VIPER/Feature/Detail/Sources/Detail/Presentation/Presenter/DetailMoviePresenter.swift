//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import RxSwift
import RxCocoa
import Common
import UIKit

enum DetailMovieSection: Int, CaseIterable {
  case header
  case preview
  case info
  case review
}

final class DetailMoviePresenter {
  var detailMovie = BehaviorRelay<Movie?>(value: nil)
  var trailerMovie = BehaviorRelay<[Video]>(value: [])
  var reviewMovie = BehaviorRelay<[Review]>(value: [])
  
  private let detailMovieRouter: DetailMovieRouterProtocol
  private let getMovieDetailInteractor: GetMovieDetailInteractor
  private let getTrailerMovieInteractor: GetTrailerVideoInteractor
  private let getReviewMovieInteractor: GetReviewMovieInteractor
  
  private let disposeBag = DisposeBag()
  var detailMovieSection = DetailMovieSection.allCases
  
  init(
    detailMovieRouter: DetailMovieRouter,
    getMovieDetailInteractor: GetMovieDetailInteractor,
    getTrailerMovieInteractor: GetTrailerVideoInteractor,
    getReviewMovieInteractor: GetReviewMovieInteractor
  ) {
    self.detailMovieRouter = detailMovieRouter
    self.getMovieDetailInteractor = getMovieDetailInteractor
    self.getTrailerMovieInteractor = getTrailerMovieInteractor
    self.getReviewMovieInteractor = getReviewMovieInteractor
  }
  

  func seeAllReviewTapped(for movieId: Int?, from viewController: UIViewController) {
    detailMovieRouter.navigateToReviewMovie(for: movieId, from: viewController)
  }
}

extension DetailMoviePresenter {
  func fetchGenresMovie(id: Int) {
    getMovieDetailInteractor.execute(request: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movie in
        self?.detailMovie.accept(movie)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchReviewMovie(id: Int) {
    getReviewMovieInteractor.execute(request: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] review in
        self?.reviewMovie.accept(review)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchTrailerMovie(id: Int) {
    getTrailerMovieInteractor.execute(request: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] video in
        self?.trailerMovie.accept(video)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func getMovieTrailer() -> Video? {
    let trailer = trailerMovie.value
    let filteredTrailer = trailer.filter { $0.type == "Trailer" }
    return filteredTrailer.first
  }
}

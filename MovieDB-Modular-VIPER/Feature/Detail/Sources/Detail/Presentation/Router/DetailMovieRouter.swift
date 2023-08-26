//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import UIKit

protocol DetailMovieRouterProtocol {
  func navigateToReviewMovie(for id: Int?, from viewController: UIViewController)
}

final class DetailMovieRouter: DetailMovieRouterProtocol {
  
  func navigateToReviewMovie(for id: Int?, from viewController: UIViewController) {
    let detailMovieVC = DetailModule().container.resolve(ReviewMovieViewController.self)!
    detailMovieVC.movieId = id
    viewController.navigationController?.pushViewController(detailMovieVC, animated: true)
  }
}

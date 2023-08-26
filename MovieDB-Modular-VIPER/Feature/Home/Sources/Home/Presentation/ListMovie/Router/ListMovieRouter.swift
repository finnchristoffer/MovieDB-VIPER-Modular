//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import Common
import Detail
import UIKit

protocol ListMovieRouterProtocol {
  func navigateToDetailMovie(for id: Int?, from viewController: UIViewController)
}

final class ListMovieRouter: ListMovieRouterProtocol {
  
  func navigateToDetailMovie(for id: Int?, from viewController: UIViewController) {
    let detailMovieVC = DetailModule().container.resolve(DetailMovieViewController.self)!
    detailMovieVC.movieId = id
    viewController.navigationController?.pushViewController(detailMovieVC, animated: true)
  }
}

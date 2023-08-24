//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import Common
import UIKit

protocol HomeRouterProtocol {
  func navigateToGenreDetail(for genre: Int?, from viewController: UIViewController)
}

final class HomeRouter: HomeRouterProtocol {
  func navigateToGenreDetail(for genre: Int?, from viewController: UIViewController) {
    let listMovieVC = HomeModule().container.resolve(ListMovieViewController.self)!
    listMovieVC.selectedGenreId = genre
    listMovieVC.hidesBottomBarWhenPushed = true
    viewController.navigationController?.pushViewController(listMovieVC, animated: true)
  }
}

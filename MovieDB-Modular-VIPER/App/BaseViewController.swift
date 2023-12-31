//
//  ViewController.swift
//  MovieDB-Modular-VIPER
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import UIKit
import Home
import Account

class BaseViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }
  
  // MARK: - Helpers
  
  private func setupTabBar() {
    let homeImage = UIImage(systemName: "house.fill")
    let homeVC = HomeModule().container.resolve(ListGenreViewController.self)
    let home = templateNavigationController(image: homeImage, rootViewController: homeVC!, title: "Home")

    let accountImage = UIImage(systemName: "person.fill")
    let account = templateNavigationController(image: accountImage, rootViewController: AccountViewController(), title: "Account")
    
    viewControllers = [home, account]
  }
  
  private func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootViewController)
    nav.tabBarItem.image = image
    nav.tabBarItem.title = title
    nav.navigationBar.tintColor = UIColor.systemBlue
    
    tabBar.tintColor = UIColor.systemBlue
    tabBar.backgroundColor = .systemBackground
    tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    tabBar.layer.shadowRadius = 2
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowOpacity = 0.3
    return nav
  }

}


//
//  HomeViewController.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 21/08/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SkeletonView
import Common

public class ListGenreViewController: UIViewController {
  
  init(presenter: ListGenrePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  private let presenter: ListGenrePresenter
  private let disposeBag = DisposeBag()
  
  // MARK: - UI Properties
  
  private lazy var tblViewGenre: UITableView = {
    let tableView = UITableView()
    tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: GenreTableViewCell.reuseIdentifier)
    tableView.isSkeletonable = true
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  private lazy var lblNoInternet: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.numberOfLines = 1
    label.textColor = UIColor.label
    label.text = "No Internet Connection"
    label.isHidden = true
    return label
  }()
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = "List Genre"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(networkStatusChanged(_:)),
      name: .networkStatusChanged,
      object: nil
    )
    
    NetworkManager.shared.startMonitoring()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    observeValues()
  }
  
  // MARK: - Helpers
  
  private func configureViews() {
    
    view.addSubview(tblViewGenre)
    tblViewGenre.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    view.addSubview(lblNoInternet)
    lblNoInternet.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func observeValues() {
    presenter.genresMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        tblViewGenre.reloadData()
      }).disposed(by: disposeBag)
  }
  
  private func checkInternetConnection() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      if NetworkManager.shared.isNetworkAvailable {
        self.presenter.fetchGenresMovie()
        self.lblNoInternet.isHidden = true
        self.tblViewGenre.isHidden = false
      } else {
        self.tblViewGenre.isHidden = true
        self.lblNoInternet.isHidden = false
      }
    }
  }
  
  @objc private func networkStatusChanged(_ notification: Notification) {
    checkInternetConnection()
  }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ListGenreViewController: UITableViewDataSource, UITableViewDelegate {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.genresMovie.value.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.reuseIdentifier, for: indexPath) as? GenreTableViewCell else { return UITableViewCell()}
    cell.data = presenter.genresMovie.value[indexPath.row]
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelectGenre(at: indexPath.row, from: self)
  }
}

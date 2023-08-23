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
import Detail

public class HomeViewController: UIViewController {
  
  init(presenter: HomePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  private let presenter: HomePresenter
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
  // MARK: - Init
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.fetchGenresMovie()
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
  }
  
  private func observeValues() {
    presenter.genresMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        tblViewGenre.reloadData()
      }).disposed(by: disposeBag)
  }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.genresMovie.value.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.reuseIdentifier, for: indexPath) as? GenreTableViewCell else { return UITableViewCell()}
    cell.data = presenter.genresMovie.value[indexPath.row]
    return cell
  }
}

//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SkeletonView
import Common

public class ReviewMovieViewController: UIViewController {
  
  init(presenter: DetailMoviePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  private let presenter: DetailMoviePresenter
  private let disposeBag = DisposeBag()
  public var movieId: Int?
  
  // MARK: - UI Properties
  private lazy var tblViewReview: UITableView = {
    let tableView = UITableView()
    tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.reuseIdentifier)
    tableView.isSkeletonable = true
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorInset = .init(top: 12, left: 0, bottom: 12, right: 0)
    tableView.separatorStyle = .none
    return tableView
  }()
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.fetchReviewMovie(id: movieId ?? 0)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    observeValues()
    configureViews()
  }
  
  // MARK: - Helpers
  
  private func configureViews() {
    view.addSubview(tblViewReview)
    tblViewReview.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func observeValues() {
    presenter.reviewMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        self.tblViewReview.reloadData()
      }).disposed(by: disposeBag)
  }
}

extension ReviewMovieViewController: UITableViewDataSource, UITableViewDelegate {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.reviewMovie.value.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell()}
    cell.data = presenter.reviewMovie.value[indexPath.row]
    return cell
  }
  
  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 12 // This adds spacing at the top of each section (optional)
  }
  
  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 12 // This adds spacing at the bottom of each section (optional)
  }
}

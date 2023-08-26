//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SkeletonView
import Common

public class DetailMovieViewController: UIViewController {
  
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
  private lazy var collectionView: UICollectionView = {
    let layout = DetailMovieViewController.createLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(MovieHeaderViewCell.self, forCellWithReuseIdentifier: MovieHeaderViewCell.reuseIdentifier)
    collectionView.register(MovieTrailerViewCell.self, forCellWithReuseIdentifier: MovieTrailerViewCell.reuseIdentifier)
    collectionView.register(MovieInfoViewCell.self, forCellWithReuseIdentifier: MovieInfoViewCell.reuseIdentifier)
    collectionView.register(MovieReviewViewCell.self, forCellWithReuseIdentifier: MovieReviewViewCell.reuseIdentifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  // MARK: - Init
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.fetchGenresMovie(id: movieId ?? 0)
    presenter.fetchTrailerMovie(id: movieId ?? 0)
    presenter.fetchReviewMovie(id: movieId ?? 0)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    observeValues()
    configureViews()
  }
  
  // MARK: - Helpers
  
  private func configureViews() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func observeValues() {
    presenter.detailMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        print("Test Detail Data \(data)")
        self.collectionView.reloadData()
      }).disposed(by: disposeBag)
    
    presenter.trailerMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        self.collectionView.reloadData()
      }).disposed(by: disposeBag)
    
    presenter.reviewMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        self.collectionView.reloadData()
      }).disposed(by: disposeBag)
  }
}

extension DetailMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return presenter.detailMovieSection.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sectionType = DetailMovieSection(rawValue: section) else {
      return 0
    }
    switch sectionType {
    case .review:
      if presenter.reviewMovie.value.isEmpty {
        return 0
      } else {
        return 1
      }
    default:
      return 1
    }
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let sectionType = DetailMovieSection(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch sectionType {
    case .header:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieHeaderViewCell.reuseIdentifier, for: indexPath) as? MovieHeaderViewCell else { return UICollectionViewCell()}
      cell.item = presenter.detailMovie.value
      return cell
    case .preview:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTrailerViewCell.reuseIdentifier, for: indexPath) as? MovieTrailerViewCell else { return UICollectionViewCell()}
      cell.item = presenter.getMovieTrailer()?.key
      return cell
    case .info:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieInfoViewCell.reuseIdentifier, for: indexPath) as? MovieInfoViewCell else { return UICollectionViewCell()}
      cell.item = presenter.detailMovie.value
      return cell
    case .review:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieReviewViewCell.reuseIdentifier, for: indexPath) as? MovieReviewViewCell else { return UICollectionViewCell()}
      cell.seeAllHandler = { [weak self] in
        guard let self = self else { return }
        self.presenter.seeAllReviewTapped(for: movieId, from: self)
        print("See All button tapped")
      }
      cell.item = presenter.reviewMovie.value
      return cell
    }
  }
}

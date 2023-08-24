//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SkeletonView
import Common

public class ListMovieViewController: UIViewController {
  
  init(presenter: ListMoviePresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  var selectedGenreId: Int?
  private var presenter: ListMoviePresenter
  private let disposeBag = DisposeBag()
  
  // MARK: - UI Properties
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 170, height: 250)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    layout.minimumLineSpacing = 16
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    return collectionView
  }()
  
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.fetchGenresMovie(genre: selectedGenreId ?? 0)
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
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func observeValues() {
    presenter.listMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        self.collectionView.reloadData()
      }).disposed(by: disposeBag)
  }
}

extension ListMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.listMovie.value.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
    cell.item = presenter.listMovie.value[indexPath.row]
    return cell
  }
  
  
}

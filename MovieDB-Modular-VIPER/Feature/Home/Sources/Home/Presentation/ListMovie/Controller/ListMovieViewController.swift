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
import Foundation

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
    navigationItem.largeTitleDisplayMode = .never
    
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(networkStatusChanged(_:)),
        name: .networkStatusChanged,
        object: nil
    )
    
    NetworkManager.shared.startMonitoring()
    
    checkInternetConnection()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    observeValues()
    configureViews()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationItem.largeTitleDisplayMode = .always
  }
  
  // MARK: - Helpers
  
  private func configureViews() {
    navigationItem.title = "List Movie"
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    view.addSubview(lblNoInternet)
    lblNoInternet.snp.makeConstraints { make in
      make.center.equalToSuperview()
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
  
  private func checkInternetConnection() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      if NetworkManager.shared.isNetworkAvailable {
        self.presenter.fetchGenresMovie(genre: self.selectedGenreId ?? 0)
        self.lblNoInternet.isHidden = true
        self.collectionView.isHidden = false
      } else {
        self.collectionView.isHidden = true
        self.lblNoInternet.isHidden = false
      }
    }
  }
  
  @objc private func networkStatusChanged(_ notification: Notification) {
      checkInternetConnection()
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
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let movieId = presenter.listMovie.value[indexPath.row].id else { return }
    presenter.didSelectMovie(with: movieId, from: self)
  }
}

//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView
import Common

class MovieReviewViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let reuseIdentifier = String(describing: MovieReviewViewCell.self)

  var item: [Review]? {
    didSet {
      tblViewReview.reloadData()
    }
  }
  
  var seeAllHandler: (() -> Void)?
  // MARK: - UI Properties
  
  private lazy var lblTitle: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.white
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.text = "Review"
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var btnSeeAll: UIButton = {
    let button = UIButton()
    button.setTitle("See All", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    button.addTarget(self, action: #selector(didSeeAllClicked), for: .touchUpInside)
    return button
  }()
  
  private lazy var tblViewReview: UITableView = {
    let tableView = UITableView()
    tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.reuseIdentifier)
    tableView.isSkeletonable = true
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    isSkeletonable = true
    skeletonCornerRadius = 16
    
    configureViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
//    lblDescription.text = ""
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func configureViews() {
    let spacerView = UIView()
    let stackHeader = UIStackView(arrangedSubviews: [lblTitle, spacerView, btnSeeAll])
    stackHeader.axis = .horizontal
    stackHeader.distribution = .fill
    
    contentView.addSubview(stackHeader)
    stackHeader.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
    }
    
    contentView.addSubview(tblViewReview)
    tblViewReview.snp.makeConstraints { make in
      make.top.equalTo(stackHeader.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview()
    }
  }
  
  @objc private func didSeeAllClicked() {
    seeAllHandler?()
  }
}

extension MovieReviewViewCell: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell()}
    cell.data = item?.first
    return cell
  }
}

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

class MovieInfoViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let reuseIdentifier = String(describing: MovieInfoViewCell.self)
  
  var item: Movie? {
    didSet {
      setContent()
    }
  }
  // MARK: - UI Properties
  
  private lazy var lblDescription: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
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
    lblDescription.text = ""
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func configureViews() {
    contentView.addSubview(lblDescription)
    lblDescription.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(30)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview()
    }
  }
  
  private func setContent() {
    lblDescription.text = item?.overview
  }
}


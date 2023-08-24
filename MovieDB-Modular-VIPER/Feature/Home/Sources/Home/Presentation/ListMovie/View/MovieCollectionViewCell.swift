//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 24/08/23.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView
import Common

class MovieCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
  
  var item: Movie? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - UI Properties
  private lazy var imgMoviePoster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var lblTitleMovie: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    isSkeletonable = true
    skeletonCornerRadius = 16
    
    configureViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imgMoviePoster.image = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Helpers
  
  private func configureViews() {
    contentView.addSubview(lblTitleMovie)
    lblTitleMovie.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    contentView.addSubview(imgMoviePoster)
    imgMoviePoster.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalTo(lblTitleMovie.snp.top).offset(-20)
    }
  }
  
  private func setContent() {
    guard let posterPath = item?.posterPath else { return }
    guard let url = URL(string: API.baseUrlImage + posterPath) else { return }
    DispatchQueue.main.async {
      self.imgMoviePoster.setImage(with: url)
    }
    
    lblTitleMovie.text = item?.title
  }
}


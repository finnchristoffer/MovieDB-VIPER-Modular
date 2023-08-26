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

class MovieHeaderViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let reuseIdentifier = String(describing: MovieHeaderViewCell.self)
  
  var item: Movie? {
    didSet {
      setContent()
    }
  }
  // MARK: - UI Properties
  private lazy var imgPoster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var lblTitle: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var lblGenre: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.secondaryLabel
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var imgStar: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "star.fill")
    imageView.tintColor = .systemYellow
    return imageView
  }()
  
  private lazy var imgHeart: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "heart.fill")
    imageView.tintColor = .systemRed
    return imageView
  }()
  
  private lazy var lblStar: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var lblHeart: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var lblReleaseDate: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .left
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
    imgPoster.image = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func configureViews() {
    let stackRate = UIStackView(arrangedSubviews: [imgStar, lblStar])
    stackRate.axis = .horizontal
    stackRate.spacing = 12
    
    let stackLove = UIStackView(arrangedSubviews: [imgHeart, lblHeart])
    stackLove.axis = .horizontal
    stackLove.spacing = 12
    
    let stackInfo = UIStackView(arrangedSubviews: [lblTitle, lblGenre, stackRate, stackLove, lblReleaseDate])
    stackInfo.axis = .vertical
    stackInfo.spacing = 12
    stackInfo.alignment = .top
    
    contentView.addSubview(imgPoster)
    imgPoster.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(10)
      make.height.equalTo(220)
      make.width.equalTo(contentView.snp.width).dividedBy(2)
    }
    
    contentView.addSubview(stackInfo)
    stackInfo.snp.makeConstraints { make in
      make.centerY.equalTo(imgPoster)
      make.leading.equalTo(imgPoster.snp.trailing).offset(8)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
  
  private func mapGenres(from Genre: [Genre]) -> [String?] {
    let data = Genre.map { $0.name }
    return data
  }
  
  private func setContent() {
    guard let posterPath = item?.posterPath else { return }
    guard let url = URL(string: API.baseUrlImage + posterPath) else { return }
    DispatchQueue.main.async {
      self.imgPoster.setImage(with: url)
    }
    
    lblTitle.text = item?.title
    let genres = mapGenres(from: item?.genres ?? [])
    let nonNilGenres = genres.compactMap { $0 }
    let genresName = nonNilGenres.joined(separator: ", ")
    lblGenre.text = genresName
    lblStar.text = "\(item?.voteAverage ?? 0.0) (\(item?.voteCount?.thousandSeparator() ?? "0"))"
    lblHeart.text = "\(item?.popularity ?? 0.0)"
    lblReleaseDate.text = item?.releaseDate
  }
}

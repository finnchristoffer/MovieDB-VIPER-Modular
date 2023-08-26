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
import YouTubeiOSPlayerHelper
import Common

class MovieTrailerViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  static let reuseIdentifier = String(describing: MovieTrailerViewCell.self)
  
  var item: String? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - UI Properties
  private lazy var webView: YTPlayerView = {
    let webView = YTPlayerView()
    return webView
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
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
  private func configureViews() {
    contentView.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setContent() {
    guard let trailerKey = item else { return }
    webView.load(withVideoId: trailerKey)
  }
}

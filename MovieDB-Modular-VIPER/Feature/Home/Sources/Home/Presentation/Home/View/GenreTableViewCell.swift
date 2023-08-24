//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 23/08/23.
//

import UIKit
import SnapKit
import SkeletonView
import Common

class GenreTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  static let reuseIdentifier = String(describing: GenreTableViewCell.self)
  
  var data: Genre? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - UI Properties
  private lazy var lblTitleGenre: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.numberOfLines = 1
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var imgChevron: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(systemName: "chevron.right")
    image.tintColor = UIColor.secondaryLabel
    return image
  }()
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)

    configureViews()
    
    isSkeletonable = true
    skeletonCornerRadius = 16
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    lblTitleGenre.text = ""
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func configureViews() {
    selectionStyle = .none
    
    contentView.addSubview(imgChevron)
    imgChevron.snp.makeConstraints { make in
      make.size.equalTo(16)
      make.trailing.equalToSuperview().offset(-10)
      make.top.bottom.equalToSuperview().inset(10)
    }
    
    contentView.addSubview(lblTitleGenre)
    lblTitleGenre.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(10)
      make.trailing.equalTo(imgChevron.snp.leading)
      make.centerY.equalTo(imgChevron)
    }
  }
  
  private func setContent() {
    guard let data = data else { return }
    lblTitleGenre.text = data.name
  }
}

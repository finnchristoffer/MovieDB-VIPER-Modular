//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 25/08/23.
//

import UIKit
import SnapKit
import SkeletonView
import Common

class ReviewTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  static let reuseIdentifier = String(describing: ReviewTableViewCell.self)
  
  var data: Review? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - UI Properties
  private lazy var lblUsername: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var lblDateComment: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 1
    label.textAlignment = .left
    label.textColor = UIColor.secondaryLabel
    return label
  }()
  
  private lazy var lblReviewUser: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 0
    label.textColor = UIColor.label
    return label
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
    lblUsername.text = ""
    lblDateComment.text = ""
    lblReviewUser.text = ""
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func configureViews() {
    selectionStyle = .none
    
    contentView.addSubview(lblUsername)
    lblUsername.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.leading.trailing.equalToSuperview()
    }
    
    contentView.addSubview(lblDateComment)
    lblDateComment.snp.makeConstraints { make in
      make.top.equalTo(lblUsername.snp.bottom)
      make.leading.trailing.equalToSuperview()
    }
    
    contentView.addSubview(lblReviewUser)
    lblReviewUser.snp.makeConstraints { make in
      make.top.equalTo(lblDateComment.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setContent() {
    guard let data = data else { return }
    lblUsername.text = data.author
    lblDateComment.text = data.createdAt
    lblReviewUser.text = data.content
  }
}

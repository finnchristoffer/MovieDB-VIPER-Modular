//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Foundation

extension String {
  public func convertToDateFormatted() -> String? {
    if let date = Date.customFormatter.date(from: self) {
      let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = "dd MMMM yyyy"
      return outputFormatter.string(from: date)
    }
    return nil
  }
  
  public func convertToDateReviewFormatted() -> String? {
    if let date = Date.customFormatterReview.date(from: self) {
      return Date.customFormatter.string(from: date)
    }
    return nil
  }
}

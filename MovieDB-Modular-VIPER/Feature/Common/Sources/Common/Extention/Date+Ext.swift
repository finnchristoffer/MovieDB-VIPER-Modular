//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Foundation

extension Date {
  public static let customFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      return formatter
  }()
  
  public static let customFormatterReview: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
      return formatter
  }()
}

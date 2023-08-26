//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Foundation

extension Int {
  public func thousandSeparator() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.groupingSeparator = "."
    numberFormatter.groupingSize = 3
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}

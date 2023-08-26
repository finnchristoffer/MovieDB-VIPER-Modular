//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 26/08/23.
//

import Network
import Foundation

public class NetworkManager {
  public static let shared = NetworkManager()
  
  private let monitor = NWPathMonitor()
  private var isMonitoring = false
  
  private init() {
    monitor.pathUpdateHandler = { path in
      NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
    }
  }
  
  public func startMonitoring() {
    if !isMonitoring {
      monitor.start(queue: DispatchQueue.global())
      isMonitoring = true
    }
  }
  
  public func stopMonitoring() {
    if isMonitoring {
      monitor.cancel()
      isMonitoring = false
    }
  }
  
  public var isNetworkAvailable: Bool {
    return monitor.currentPath.status == .satisfied
  }
}

extension Notification.Name {
  public static let networkStatusChanged = Notification.Name("NetworkStatusChanged")
}

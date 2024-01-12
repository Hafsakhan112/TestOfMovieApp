//
//  NetworkMonitor.swift
//  MovieApp
//
//  Created by Hafsa Khan on 08/01/2024.
//

import Foundation
import Network


class NetworkMonitor {
    static let shared = NetworkMonitor()
      
      private let monitor: NWPathMonitor
      private let queue = DispatchQueue(label: "NetworkMonitor")
      
      var isConnected: Bool = false
      
      private init() {
          // Initialize the monitor
          monitor = NWPathMonitor()
          
          // Set up the path update handler
          monitor.pathUpdateHandler = { [weak self] path in
              print("Network status updated: \(path.status)")
              self?.isConnected = path.status == .satisfied
          }
          
          // Start monitoring
          monitor.start(queue: queue)
      }
      
      deinit {
          // Stop monitoring when the instance is deallocated
          monitor.cancel()
      }
}

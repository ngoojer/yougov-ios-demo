import Foundation
import Network

class NetworkMonitor {
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    static let shared = NetworkMonitor()
    private init () {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { pathUpdateHandler in
              if pathUpdateHandler.status == .satisfied {
                  print("Internet connection is on.")
              } else {
                  print("There's no internet connection.")
              }
          }
        monitor?.start(queue: queue)
    }
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
}

//
//  NetworkService.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/8.
//

import Foundation
import Network

enum ConnectionType {
    case wifi, ethernet, cellular, unknown
}

class NetworkService: ObservableObject {
    @Published var connected = false
    @Published var type: ConnectionType = .wifi
    
    var monitor: NWPathMonitor
    var queue: DispatchQueue
    
    init() {
        queue = DispatchQueue(label: "Monitor")
        monitor = NWPathMonitor()
        
        monitor.start(queue: queue)
    }
    
    func start(listener: @escaping () -> ()) {
        monitor.pathUpdateHandler = { path in
            self.connected = path.status == .satisfied
            self.type = self.checkType(path)
            print("network: \(self.type)")
            if (self.connected) {
                print("fetch weather again")
                listener()
            }
        }
    }
    
    func stop() {
        monitor.cancel()
    }
    
    func checkType(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        
        return .unknown
    }
}

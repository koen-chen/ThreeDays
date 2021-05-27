//
//  NetworkProvider.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/8.
//

import Foundation
import Network

enum ConnectionType {
    case wifi, ethernet, cellular, unknown
}

enum ConnectionStatus {
    case connected, disconnected
}

class NetworProvider: ObservableObject {
    @Published var status: ConnectionStatus = .disconnected
    @Published var type: ConnectionType = .wifi
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.type = self.checkType(path)
                if path.status == .satisfied {
                    self.status = .connected
                } else {
                    self.status = .disconnected
                }
            }
        }
        
        monitor.start(queue: queue)
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

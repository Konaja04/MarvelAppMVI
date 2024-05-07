//
//  ComicNetworkManager.swift
//  MarvelApp-Clean
//
//  Created by Kohji Onaja on 16/04/24.
//

import Foundation
import Network
//
//@globalActor struct NetworkMonitorGlobalActor {
//    static let shared = NetworkMonitor()
//}

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false

    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
    }

    
}

//
//  MarvelAppMVIApp.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

@main
struct YourApp: App {
    let networkMonitor = NetworkMonitor.shared
    
    init() {
        networkMonitor.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  ThreeDaysApp.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/4/29.
//

import SwiftUI

@main
struct ThreeDaysApp: App {
    // let network = NetworkService()
    let persistenceProvider = PersistenceProvider.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceProvider.managedObjectContext)
                .environmentObject(Theme())
                .environmentObject(WeatherViewModel())
                .environmentObject(PlaceViewModel())
        }
    }
}

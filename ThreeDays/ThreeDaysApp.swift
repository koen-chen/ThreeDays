//
//  ThreeDaysApp.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/4/29.
//

import SwiftUI

@main
struct ThreeDaysApp: App {
    let persistenceService = PersistenceService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceService.managedObjectContext)
                .environmentObject(Theme())
                .environmentObject(WeatherViewModel())
                .environmentObject(PlaceListViewModel())
        }
    }
}

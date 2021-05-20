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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Theme())
                .environmentObject(WeatherViewModel())
        }
    }
}

class Theme: ObservableObject {
    var isDaytime: Bool {
        let d = Calendar.current.dateComponents(in: TimeZone(abbreviation: "GMT+8")!, from: Date())
        return d.hour! > 18 ? false : true
    }

    var backgroundColor: Color {
        return  isDaytime ? Color(#colorLiteral(red: 0.2862745098, green: 0.5803921569, blue: 0.768627451, alpha: 1)) : Color(#colorLiteral(red: 0.7333333333, green: 0.6823529412, blue: 0.7960784314, alpha: 1))
    }

    var textColor: Color {
        return isDaytime ? Color(#colorLiteral(red: 0.2862745098, green: 0.5803921569, blue: 0.768627451, alpha: 1)) : Color(#colorLiteral(red: 0.4901960784, green: 0.3215686275, blue: 0.5176470588, alpha: 1))
    }

    var iconText: String {
        return isDaytime ? "day" : "night"
    }
}

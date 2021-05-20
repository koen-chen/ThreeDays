//
//  ContentView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/4/29.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct ContentView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var weatherStore: WeatherViewModel
    
    @State var showDayList = false
    @State var activeDay = 0
    @State var showCityList = false
    @State var activeCity: String?
    
    var placeCity: String {
        return activeCity ?? weatherStore.placeLocality
    }

    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial).background(theme.backgroundColor)
            
            if weatherStore.weather.result.now != nil {
                DayView(
                    activeDay: activeDay,
                    placeCity: placeCity,
                    showDayList: $showDayList,
                    showCityList: $showCityList
                )
                .padding(.vertical, 30)
                .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
                .cornerRadius(30)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .offset(y: showDayList ? 200 : 0)
                .offset(y: showCityList ? -300 : 0)
                .padding(.horizontal, showDayList ? 10 : 0)
                .padding(.horizontal, showCityList ? 10 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            } else {
                LottieView(name: "loading2-\(theme.iconText)")
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
            DayListView(showDayList: $showDayList, activeDay: $activeDay)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .offset(y: showDayList ? 10 : -screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))

            CityListView(showCityList: $showCityList, activeCity: $activeCity)
                .offset(y: showCityList ? 10 : screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Theme())
            .environmentObject(WeatherViewModel())
    }
}

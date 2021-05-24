//
//  ContentView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/4/29.
//

import SwiftUI
import CoreData

let screen = UIScreen.main.bounds

struct ContentView: View {
    private let context = PersistenceProvider.shared.managedObjectContext

    @EnvironmentObject var theme: Theme
    @EnvironmentObject var weatherStore: WeatherViewModel
    @EnvironmentObject var placeStore: PlaceViewModel
    
    @State var showDayList = false
    @State var activeDay = 0
    @State var showCityList = false

    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial).background(theme.backgroundColor)
            
            if placeStore.districtCode != nil {
                WeatherView(
                    activeDay: activeDay,
                    showDayList: $showDayList,
                    showCityList: $showCityList
                )
                .onReceive(placeStore.$districtCode, perform: { value in
                    weatherStore.getWeather(districtId: String(value!))
                })
                .padding(.vertical, 30)
                .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
                .cornerRadius(30)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .offset(y: showDayList ? CGFloat(200) : 0)
                .offset(y: showCityList ? CGFloat(-360) : 0)
                .padding(.horizontal, showDayList ? 10 : CGFloat.zero)
                .padding(.horizontal, showCityList ? 10 : CGFloat.zero)
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

            CityListView(showCityList: $showCityList)
                .offset(y: showCityList ? 10 : screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
                .environment(\.managedObjectContext, context)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Theme())
            .environmentObject(WeatherViewModel())
            .environmentObject(PlaceViewModel())
    }
}

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
    
    //@Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var weatherStore: WeatherViewModel
    
//    @FetchRequest(
//        entity: City.entity(),
//        sortDescriptors: []
//    ) var cityList: FetchedResults<City>
//
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

            CityListView(showCityList: $showCityList, activeCity: $activeCity)
                .onReceive(weatherStore.$placeLocality, perform: { value in
                    self.activeCity = value
                })
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
    }
}

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
    @State var cityListDragState = CGSize.zero
    @State var showCityListFull = false
    
    var cityListShowHeight = screen.height < 800 ? screen.height / 2 : 500
    
    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial).background(theme.backgroundColor)
            
            if placeStore.activePlace?.districtCode != nil {
                WeatherView(
                    activeDay: activeDay,
                    showDayList: $showDayList,
                    showCityList: $showCityList
                )
                .onReceive(placeStore.$activePlace, perform: { place in
                    if let code = place?.districtCode {
                        weatherStore.getWeather(districtId: String(code))
                    }
                })
                .padding(.vertical, 30)
                .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
                .cornerRadius(30)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .offset(y: showDayList ? CGFloat(200) : 0)
                .offset(y: showCityList ? -(screen.height - cityListShowHeight) : 0)
                .offset(y: cityListDragState.height)
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
                .offset(y: showCityList ? cityListShowHeight + 20 : screen.height)
                .offset(y: cityListDragState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
                .environment(\.managedObjectContext, context)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.cityListDragState = value.translation
                            
                            if self.showCityListFull {
                                self.cityListDragState.height += -300
                            }
                            
                            if self.cityListDragState.height < -300 {
                                self.cityListDragState.height = -300
                            }
                        })
                        .onEnded({ value in
                            if self.cityListDragState.height > 50 {
                                self.showCityList = false
                            }
                            
                            if (self.cityListDragState.height < -100 && !self.showCityListFull) || (self.cityListDragState.height < -250 && self.showCityListFull) {
                                self.cityListDragState.height = -300
                                self.showCityListFull = true
                            } else {
                                self.cityListDragState = .zero
                                self.showCityListFull = false
                            }
                        })
                )
                .onChange(of: showCityList) { value in
                    if !value {
                        self.cityListDragState = .zero
                        self.showCityListFull = false
                    }
                    
                    print(screen.height)
                }
        
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

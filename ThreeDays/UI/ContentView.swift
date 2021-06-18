//
//  ContentView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/4/29.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let context = PersistenceService.shared.managedObjectContext

    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: WeatherViewModel
    
    @StateObject var netMonitor = NetworkService()
    @State var showDayList = false
    @State var activeDay = 0
    @State var showCityList = false
    @State var showCityListFull = false
    @State var showProfileView = false
    @State var showWeatherDetail = false
    @State var weatherDragState = CGSize.zero
    @State var tempWeatherDragState = CGSize.zero
    @State var weatherAPIDone = false
    
    @State var showDailyPreview = false
    
    var isConnected: Bool {
        return netMonitor.status == .connected ? true : false
    }
    
    var cityListShowHeight: CGFloat {
        return theme.screen.height < 800 ? theme.screen.height / 2 : 500
    }
    
    var showPreviewGesture: some Gesture  {
        DragGesture()
            .onEnded { value in
                if value.translation.width < -50 || value.translation.width > 30 {
                    if !self.showDayList, !self.showCityList {
                        showDailyPreview.toggle()
                    }
                }
            }
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .systemMaterial).background(theme.backgroundColor)
          
            HStack(alignment: .top, spacing: 0) {
                WeatherView(
                    activeDay: showDailyPreview ? 0 : activeDay,
                    showDayList: $showDayList,
                    showCityList: $showCityList,
                    showWeatherDetail: $showWeatherDetail,
                    showDailyPreview: $showDailyPreview,
                    showProfileView: $showProfileView
                )
                .frame(maxWidth: showDailyPreview ? theme.screen.width / 3 : .infinity)
                .contentShape(Rectangle())
                .padding(.vertical, 30)
                .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
                .cornerRadius((showCityList || showDayList) ? 30 : 0)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .offset(y: showDayList ? CGFloat(200) : 0)
                .offset(y: showCityList ? -(theme.screen.height - cityListShowHeight) : 0)
                .offset(y: weatherDragState.height)
                .padding(.horizontal, showDayList ? 10 : CGFloat.zero)
                .padding(.horizontal, showCityList ? 10 : CGFloat.zero)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            if value.translation.height < -50 || value.translation.height > 50 {
                                self.weatherDragState = value.translation

                                if (self.weatherDragState.height + self.tempWeatherDragState.height) > 100 {
                                    self.weatherDragState.height = 50

                                    self.showCityList = false
                                    self.showDayList = true
                                }

                                if (self.weatherDragState.height + self.tempWeatherDragState.height)  < -100 {
                                    self.weatherDragState.height = -100
                                    self.showCityList = true
                                    self.showDayList = false
                                }
                            }
                        })
                        .onEnded({ value in
                            if self.weatherDragState.height < -10 {
                                self.showDayList = false
                            }

                            if self.weatherDragState.height > 50 {
                                self.showCityList = false
                            }

                            if !self.showDayList, !self.showCityList {
                                if value.translation.width < -50 {
                                    showProfileView ? showProfileView.toggle() : showDailyPreview.toggle()
                                }

                                if value.translation.width > 50 {
                                    showDailyPreview ? showDailyPreview.toggle() : showProfileView.toggle()
                                }
                            }

                            self.tempWeatherDragState = self.weatherDragState

                            self.weatherDragState = .zero
                        })
                )
                .onChange(of: showCityList) { value in
                    if !value {
                        self.weatherDragState = .zero
                        self.showCityListFull = false
                    }
                }
                .simultaneousGesture(
                    TapGesture().onEnded({ _ in
                        if showDailyPreview {
                            activeDay = 0
                            showDailyPreview = false
                        }
                    })
                )

                WeatherView(
                    activeDay: 1,
                    showDayList: $showDayList,
                    showCityList: $showCityList,
                    showWeatherDetail: $showWeatherDetail,
                    showDailyPreview: $showDailyPreview,
                    showProfileView: $showProfileView
                )
                .frame(width: showDailyPreview ? theme.screen.width / 3 : 0)
                .contentShape(Rectangle())
                .padding(.vertical, 30)
                .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
                .cornerRadius((showCityList || showDayList) ? 30 : 0)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .gesture(showPreviewGesture)
                .simultaneousGesture(
                    TapGesture().onEnded({ _ in
                        if showDailyPreview {
                            activeDay = 1
                            showDailyPreview = false
                        }
                    })
                )

                WeatherView(
                    activeDay: 2,
                    showDayList: $showDayList,
                    showCityList: $showCityList,
                    showWeatherDetail: $showWeatherDetail,
                    showDailyPreview: $showDailyPreview,
                    showProfileView: $showProfileView
                )
                .frame(width: showDailyPreview ? theme.screen.width / 3 : 0)
                .contentShape(Rectangle())
                .padding(.vertical, 30)
                .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
                .cornerRadius((showCityList || showDayList) ? 30 : 0)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .gesture(showPreviewGesture)
                .simultaneousGesture(
                    TapGesture().onEnded({ _ in
                        if showDailyPreview {
                            activeDay = 2
                            showDailyPreview = false
                        }
                    })
                )
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))

            LaunchView()
                .opacity((weatherAPIDone && isConnected) ? 0 : 1)
                .onReceive(viewModel.$weatherNow, perform: { weather in
                    if weather?.now != nil {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation() {
                                self.weatherAPIDone = true
                            }
                        }
                    }
                })

            
            DayListView(showDayList: $showDayList, activeDay: $activeDay)
                .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
                .offset(y: showDayList ? 10 : -theme.screen.height)
                .offset(y: weatherDragState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))

            PlaceListView(showCityList: $showCityList)
                .offset(y: showCityList ? cityListShowHeight + 20 : theme.screen.height)
                .offset(y: weatherDragState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
                .environment(\.managedObjectContext, context)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.weatherDragState = value.translation

                            if self.showCityListFull {
                                self.weatherDragState.height += -300
                            }

                            if self.weatherDragState.height < -300 {
                                self.weatherDragState.height = -300
                            }
                        })
                        .onEnded({ value in
                            if self.weatherDragState.height > 50 {
                                self.showCityList = false
                            }

                            if (self.weatherDragState.height < -100 && !self.showCityListFull) || (self.weatherDragState.height < -250 && self.showCityListFull) {
                                self.weatherDragState.height = -300
                                self.showCityListFull = true
                            } else {
                                self.weatherDragState = .zero
                                self.showCityListFull = false
                            }
                        })
                )
                .onChange(of: showCityList) { value in
                    if !value {
                        self.weatherDragState = .zero
                        self.showCityListFull = false
                    }
                }

            WeatherDetailView(showWeatherDetail: $showWeatherDetail)
                .frame(width: showWeatherDetail ? theme.screen.width : 0, height: showWeatherDetail ? theme.screen.height : 0)
                .opacity(showWeatherDetail ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))


            ProfileView(showProfileView: $showProfileView)
                .offset(x: showProfileView ? 0 : -theme.screen.width)
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
            .environmentObject(PlaceListViewModel())
    }
}

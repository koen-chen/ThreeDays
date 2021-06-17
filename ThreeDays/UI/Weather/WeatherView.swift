//
//  WeatherView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/14.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var activeDay: Int
    @Binding var showDayList: Bool
    @Binding var showCityList: Bool
    @Binding var showWeatherDetail: Bool
    @Binding var showDailyPreview: Bool
    @Binding var showProfileView: Bool

    var dateText: (Int, Int) {
        guard let daily = viewModel.weatherDaily?.daily[self.activeDay] else {
            return (1, 1)
        }
   
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[1])!, Int(temp[2])!)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: 40, height: 6)
                    .foregroundColor(theme.textColor)
                    .cornerRadius(3)
                    .opacity(0.5)
                    .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
            
                Spacer()
            }
            .opacity(showDayList ? 1 : 0)
            
           
            HStack(alignment: showDailyPreview ? .center : .firstTextBaseline) {
                if !showDailyPreview {
                    Button(action: {
                        self.showProfileView.toggle()
                    }, label: {
                        Image(systemName: "circle.bottomhalf.fill")
                            .font(.system(size: 18))
                            .padding(.all, 30)
                            .offset(y: 20)
                    })
                    
                    Spacer()
                }
                
                DayView(
                    dailyText: Description.dayDesc(activeDay),
                    dateText: dateText,
                    showDayList: showDailyPreview ? .constant(false) : $showDayList
                )
                .font(.custom(theme.font, size: showDailyPreview ? 38 : 40))
            }
            
            
            if let dailyWeather = viewModel.weatherDaily?.daily[self.activeDay] {
                VStack(alignment: .center, spacing: 15) {
                    if !showDailyPreview {
                        VStack {
                            LottieView(
                                isWeather: true,
                                weatherCode: theme.isDaytime ? dailyWeather.iconDay : dailyWeather.iconNight
                            )
                            .frame(width: 160, height: 160)
                            .padding(.bottom, 10)
                        }
                        .onTapGesture(perform: {
                            if !showDailyPreview {
                                self.showWeatherDetail.toggle()
                            }
                        })
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(Description.weatherDesc(theme.isDaytime ? dailyWeather.textDay : dailyWeather.textNight))")
                            .font(.custom(theme.font, size: showDailyPreview ? 48 : 62))
                            .frame(maxWidth: showDailyPreview ? 60 : .infinity)
                            .frame(height: showDailyPreview ? 240 : nil)
                        
                        if !showDailyPreview, activeDay == 0, let nowWeather = viewModel.weatherNow?.now {
                            Text("\(nowWeather.temp)°")
                                .font(.custom(theme.font, size: 60))
                                .offset(x: 10)
                        }
                        
                        if showDailyPreview {
                            VStack(alignment: .center, spacing: 10) {
                                TempLimitView(label: "最高", value: dailyWeather.tempMax)
                                Divider().background(theme.backgroundColor).padding(.horizontal, 30)
                                TempLimitView(label: "最低", value: dailyWeather.tempMin)
                            }
                            
                            VStack(spacing: 10) {
                                Text("\(dailyWeather.windDirDay)")
                                Text("\(dailyWeather.windSpeedDay)级")
                            }
                            .padding(.top, 50)
                        } else {
                            HStack(alignment: .center, spacing: 20) {
                                TempLimitView(label: "最低", value: dailyWeather.tempMin)
                                TempLimitView(label: "最高", value: dailyWeather.tempMax)
                            }
                            .padding(.top, 15)
                        }
                    }
                }
                .offset(y: -20)
                .padding(.top, showDailyPreview ? 60 : 0)
                .padding(.bottom, showDailyPreview ? 20 : 0)
            }
            
            if !showDailyPreview {
                PlaceView(showCityList: $showCityList)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
 
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(
            activeDay: 0,
            showDayList: .constant(false),
            showCityList: .constant(false),
            showWeatherDetail: .constant(false),
            showDailyPreview: .constant(false),
            showProfileView: .constant(false)
        )
        .environmentObject(Theme())
        .environmentObject(WeatherViewModel())
        .environmentObject(PlaceListViewModel())
    }
}

struct TempLimitView: View {
    @EnvironmentObject var theme: Theme
    var label: String
    var value: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("\(label)")
                .font(.custom(theme.font, size: 16))
                .opacity(0.9)
            
            Text("\(value)°")
                .font(.custom(theme.font, size: 20))
        }
        .offset(x: 5)
    }
}

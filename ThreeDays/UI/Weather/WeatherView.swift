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
    @State var showProfileView: Bool = false
    
    var dailyText: String {
        return Description.dayDesc(activeDay)
    }
    
    var nowWeather: WeatherNowModel.Now? {
        return viewModel.weatherNow?.now ?? nil
    }
    
    var dailyWeather: WeatherDailyModel.Daily? {
        return viewModel.weatherDaily?.daily[self.activeDay] ?? nil
    }
    
    var weatherDesc: String {
        guard let daily = dailyWeather else {
            return ""
        }
    
        let text = theme.isDaytime ? daily.textDay : daily.textNight
        return Description.weatherDesc(text)
    }

    var dateText: (Int, Int) {
        guard let daily = dailyWeather else {
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
                    .fullScreenCover(isPresented: $showProfileView) {
                        ProfileView()
                    }
                    
                    Spacer()
                }
                
                
                DayView(
                    dailyText: dailyText,
                    dateText: dateText,
                    showDayList: showDailyPreview ? .constant(false) : $showDayList
                )
                .font(.custom(theme.font, size: showDailyPreview ? 38 : 40))
            }
            
            
            VStack(alignment: .center, spacing: 15) {
                if !showDailyPreview {
                    VStack {
                        LottieView(isWeather: true, weatherCode: nowWeather?.icon)
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
                    Text("\(weatherDesc)")
                        .font(.custom(theme.font, size: showDailyPreview ? 48 : 62))
                        .frame(maxWidth: showDailyPreview ? 60 : .infinity)
                        .frame(height: showDailyPreview ? 240 : nil)
                    
                    if !showDailyPreview && activeDay == 0 {
                        Text("\(nowWeather?.temp ?? "")°")
                            .font(.custom(theme.font, size: 60))
                            .offset(x: 10)
                    }
                    
                    if showDailyPreview {
                        VStack(alignment: .center, spacing: 10) {
                            TempLimitView(label: "最高", value: dailyWeather?.tempMax ?? "")
                            Divider().background(theme.backgroundColor).padding(.horizontal, 30)
                            TempLimitView(label: "最低", value: dailyWeather?.tempMin ?? "")
                        }
                    } else {
                        HStack(alignment: .center, spacing: 20) {
                            TempLimitView(label: "最低", value: dailyWeather?.tempMin ?? "")
                            TempLimitView(label: "最高", value: dailyWeather?.tempMax  ?? "")
                        }
                        .padding(.top, 15)
                    }
                    
                    if showDailyPreview {
                        if let windDirDay = dailyWeather?.windDirDay,
                           let windSpeedDay = dailyWeather?.windSpeedDay {
                            VStack(spacing: 10) {
                                Text("\(windDirDay)")
                                Text("\(windSpeedDay)级")
                            }
                            .padding(.top, 50)
                        }
                    }
                }
            }
            .offset(y: -20)
            .padding(.top, showDailyPreview ? 60 : 0)
            .padding(.bottom, showDailyPreview ? 20 : 0)
            
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
            showDailyPreview: .constant(false)
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

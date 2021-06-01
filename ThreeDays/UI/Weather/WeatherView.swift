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
            
            DayView(
                dailyText: dailyText,
                dateText: dateText,
                showDayList: $showDayList
            )
            
            VStack(alignment: .center, spacing: 15) {
                VStack {
                    LottieView(isWeather: true, weatherDesc: weatherDesc)
                        .frame(width: 180, height: 180)
                        .padding(.bottom, 20)
                }
                
                VStack(alignment: .center, spacing: 15) {
                    Text("\(weatherDesc)")
                        .font(.custom(theme.font, size: 66))
                    
                    if activeDay == 0 {
                        ZStack(alignment: .bottom) {
                            Text("\(nowWeather?.temp ?? "")°")
                                .font(.custom(theme.font, size: 66))
                                .offset(x: 10)
                
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 20) {
                        Text("最低 \(dailyWeather?.tempMin ?? "")°")
                        Text("最高 \(dailyWeather?.tempMax ?? "")°")
                    }
                    .font(.custom(theme.font, size: 18))
                    .padding(.top, theme.screen.height < 800 ? 0 : 30)
                    .offset(x: 5)
                }
            }
            .offset(y: -20)
            
            PlaceView(showCityList: $showCityList)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(activeDay: 0, showDayList: .constant(false), showCityList: .constant(false))
            .environmentObject(Theme())
            .environmentObject(WeatherViewModel())
            .environmentObject(PlaceListViewModel())
    }
}

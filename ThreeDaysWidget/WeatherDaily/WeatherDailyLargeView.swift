//
//  WeatherDailyLargeView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/26.
//

import SwiftUI

struct WeatherDailyLargeView: View {
    @EnvironmentObject var theme: Theme
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceName: String?
    
    var body: some View {
        ZStack {
            theme.backgroundColor.opacity(0.3).ignoresSafeArea()
            
            HStack(alignment: .top, spacing: 0) {
                WeatherItem(
                    activeDay: 0,
                    nowWeather: nowWeather,
                    dailyWeather: dailyWeather,
                    activePlaceName: activePlaceName
                )
                .frame(maxWidth: theme.screen.width / 3)
                
                Divider().background(theme.backgroundColor.opacity(0.4))
                
                WeatherItem(
                    activeDay: 1,
                    nowWeather: nowWeather,
                    dailyWeather: dailyWeather,
                    activePlaceName: activePlaceName
                )
                .frame(maxWidth: theme.screen.width / 3)
                
                Divider().background(theme.backgroundColor.opacity(0.4))
                
                WeatherItem(
                    activeDay: 2,
                    nowWeather: nowWeather,
                    dailyWeather: dailyWeather,
                    activePlaceName: activePlaceName
                )
                .frame(maxWidth: theme.screen.width / 3)
            }
        }
        .font(.custom(theme.font, size: 12))
        .foregroundColor(theme.textColor)
    }
}


private struct WeatherItem: View {
    @EnvironmentObject var theme: Theme
    let activeDay: Int
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceName: String?
    
    var dateText: (Int, Int, Int) {
        guard let daily = dailyWeather?.daily[activeDay] else {
            return (0, 0, 0)
        }
        
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[0])!, Int(temp[1])!, Int(temp[2])!)
    }
    
    var lunarInfo: String? {
        guard dateText != (0,0,0) else { return nil }
        return LunarService.getLunarSpecialDate(iYear: dateText.0, iMonth: dateText.1, iDay: dateText.2)
    }
    
    var body: some View {
        ZStack {
            if let dailyWeather = dailyWeather?.daily[activeDay], let nowWeather = nowWeather?.now {
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        
                        HStack(alignment: .top, spacing: 10) {
                            HStack {
                                if let lunarInfo = lunarInfo {
                                    Text(lunarInfo)
                                        .padding(.vertical, 4)
                                        .frame(width: 20)
                                        .cornerRadius(6)
                                        .font(.custom(theme.font, size: 12))
                                        .background(theme.backgroundColor.opacity(0.1))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6).stroke(theme.backgroundColor.opacity(0.6), lineWidth: 1)
                                        )
                                }
                                
                                Text(Description.dayDesc(activeDay))
                                    .font(.custom(theme.font, size: 20))
                                
                            }
                            
                            VStack(spacing: 0) {
                                Image(systemName: "circle.righthalf.fill")
                                    .padding(.bottom, 2)
                                
                                Text("\(dateText.1)")
                                Text("月")
                                Text("\(dateText.2)")
                                Text("日")
                            }
                            .font(.custom(theme.font, size: 10))
                            .offset(y: 15)
                        }
                        .padding(.trailing, 5)
                    }
                    
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    Text("\(Description.weatherDesc(activeDay == 0 ? nowWeather.text : (theme.isDaytime ? dailyWeather.textDay : dailyWeather.textNight)))")
                        .font(.custom(theme.font, size: 28))
                        .frame(maxWidth: 40)
                }
                .offset(y: -30)
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("\(dailyWeather.tempMax)°")
                            .font(.custom(theme.font, size: 14))
                        Divider().background(theme.backgroundColor).padding(.horizontal, 35)
                        Text("\(dailyWeather.tempMin)°")
                            .font(.custom(theme.font, size: 14))
                    }
                    .padding(.bottom, 5)
                    
                    HStack(spacing: 5) {
                        Text("\(dailyWeather.windDirDay)")
                        Image(systemName: "circlebadge.fill")
                            .font(.system(size: 6))
                            .opacity(0.9)
                        Text("\(dailyWeather.windSpeedDay)级")
                    }
                }
                .offset(y: -40)
                
                if activeDay == 1 {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text(activePlaceName ?? "未知")
                        }
                    }
                }
            } else {
                WidgetNotAvailableView()
            }
        }
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
        .padding(.all, 10)
    }
}

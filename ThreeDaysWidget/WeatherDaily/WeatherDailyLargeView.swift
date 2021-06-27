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


struct WeatherItem: View {
    @EnvironmentObject var theme: Theme
    let activeDay: Int
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceName: String?
    
    var dateText: (Int, Int) {
        guard let daily = dailyWeather?.daily[activeDay] else {
            return (1, 1)
        }
        
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[1])!, Int(temp[2])!)
    }
    
    var body: some View {
        ZStack {
            if let dailyWeather = dailyWeather?.daily[0], let nowWeather = nowWeather?.now {
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        
                        HStack(alignment: .top, spacing: 10) {
                            Text(Description.dayDesc(activeDay))
                                .font(.custom(theme.font, size: 20))
                            
                            VStack(spacing: 0) {
                                Image(systemName: "circle.righthalf.fill")
                                    .padding(.bottom, 2)
                                
                                Text("\(dateText.0)")
                                Text("月")
                                Text("\(dateText.1)")
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
            }
        }
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
        .padding(.all, 10)
    }
}

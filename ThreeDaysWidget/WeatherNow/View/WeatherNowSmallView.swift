//
//  WeatherNowSmallView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/26.
//

import SwiftUI

struct WeatherNowSmallView: View {
    @EnvironmentObject var theme: Theme
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceName: String?
    
    var dateText: (Int, Int, Int) {
        guard let daily = dailyWeather?.daily[0] else {
            return (0, 0, 0)
        }
        
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[0])!, Int(temp[1])!, Int(temp[2])!)
    }
    
    var body: some View {
        ZStack {
            theme.backgroundColor.opacity(0.2).ignoresSafeArea()
            
            ZStack {
                if let dailyWeather = dailyWeather?.daily[0], let nowWeather = nowWeather?.now {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            
                            HStack(alignment: .top) {
                                Text("今\n日")
                                    .font(.custom(theme.font, size: 16))
                                    .offset(y: 4)
                                
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
                        }
                        
                        Spacer()
                    }
                    
                    
                    VStack(spacing: 0) {
                        HStack {
                            VStack(alignment: .center, spacing: 2) {
                                Text("\(Description.weatherDesc(nowWeather.text))")
                                    .font(.custom(theme.font, size: 26))
                                
                                Text("\(nowWeather.temp)°")
                                    .font(.custom(theme.font, size: 22))
                                    .offset(x: 4)
                                
                                HStack(spacing: 5) {
                                    Text("\(dailyWeather.tempMin)°")
                                        .font(.custom(theme.font, size: 12))
                                    Text("/").font(.system(size: 10))
                                    Text("\(dailyWeather.tempMax)°")
                                        .font(.custom(theme.font, size: 12))
                                }
                                .padding(.top, 5)
                                
                            }
                            .offset(x: 10)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    
                    
                    VStack {
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 5) {
                            Image(systemName: "circle.lefthalf.fill")
                                .font(.system(size: 10))
                            
                            Text(activePlaceName ?? "未知")
                            
                            Spacer()
                        }
                        .offset(x: 10)
                    }
                    
                } else {
                    WidgetNotAvailableView()
                }
            }
            .padding(.all, 10)
        }
        .font(.custom(theme.font, size: 14))
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
    }
}

//
//  WeatherDailyWidgetView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit
import SwiftUI

struct WeatherDailyWidgetView: View {
    @EnvironmentObject var theme: Theme
    var entry: WidgetTimelineProvider.Entry
    
    var body: some View {
        ZStack {
            theme.backgroundColor.opacity(0.2).ignoresSafeArea()
            
            HStack(alignment: .top, spacing: 0) {
                WeatherItem(
                    activeDay: 0,
                    nowWeather: entry.nowWeather,
                    dailyWeather: entry.dailyWeather
                )
                .frame(maxWidth: theme.screen.width / 3)
                
                Divider().background(theme.backgroundColor)
                
                WeatherItem(
                    activeDay: 1,
                    nowWeather: entry.nowWeather,
                    dailyWeather: entry.dailyWeather
                )
                .frame(maxWidth: theme.screen.width / 3)
                
                Divider().background(theme.backgroundColor)
               
                WeatherItem(
                    activeDay: 2,
                    nowWeather: entry.nowWeather,
                    dailyWeather: entry.dailyWeather
                )
                .frame(maxWidth: theme.screen.width / 3)
            }
        }
        .font(.custom(theme.font, size: 14))
        .foregroundColor(theme.textColor)
    }
}


struct WeatherDailyWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDailyWidgetView(
            entry: WeatherEntry(
                date: Date(),
                nowWeather: WeatherNowModel(now: WeatherNowModel.Now(text: "多云", icon: "101", temp: "33", feelsLike: "35", wind360: "180", windDir: "南风", windSpeed: "14", humidity: "59", vis: "19"), code: "200", updateTime: "2021-06-25T11:52+08:00"),
                dailyWeather: WeatherDailyModel(daily: [WeatherDailyModel.Daily(fxDate: "2021-06-25", tempMax: "34", tempMin: "26", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "92", vis: "21", uvIndex: "10", moonPhase: "满月"), WeatherDailyModel.Daily(fxDate: "2021-06-26", tempMax: "35", tempMin: "27", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "90", vis: "24", uvIndex: "7", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-27", tempMax: "33", tempMin: "27", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "225", windDirNight: "西南风", windSpeedNight: "3", humidity: "96", vis: "17", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-28", tempMax: "28", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "307", textNight: "大雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "95", vis: "24", uvIndex: "3", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-29", tempMax: "29", tempMin: "24", iconDay: "306", textDay: "中雨", iconNight: "307", textNight: "大雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "94", vis: "14", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-30", tempMax: "26", tempMin: "25", iconDay: "307", textDay: "大雨", iconNight: "306", textNight: "中雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "97", vis: "20", uvIndex: "3", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-07-01", tempMax: "28", tempMin: "26", iconDay: "306", textDay: "中雨", iconNight: "305", textNight: "小雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "97", vis: "19", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-07-02", tempMax: "31", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "4", moonPhase: "下弦月"), WeatherDailyModel.Daily(fxDate: "2021-07-03", tempMax: "32", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "91", vis: "24", uvIndex: "4", moonPhase: "残月"), WeatherDailyModel.Daily(fxDate: "2021-07-04", tempMax: "31", tempMin: "24", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "315", windDirDay: "西北风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "3", moonPhase: "残月")], code: "200", updateTime: "2021-06-25T11:35+08:00")
            )
        )
        .environmentObject(Theme())
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

struct WeatherItem: View {
    @EnvironmentObject var theme: Theme
    let activeDay: Int
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    
    var dateText: (Int, Int) {
        guard let daily = dailyWeather?.daily[activeDay] else {
            return (1, 1)
        }
        
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[1])!, Int(temp[2])!)
    }
    
    var Line: some View {
        VStack {
            Divider().background(theme.backgroundColor)
        }
    }
    
    var body: some View {
        ZStack {
            if let dailyWeather = dailyWeather?.daily[0], let nowWeather = nowWeather?.now {
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        
                        HStack(alignment: .top, spacing: 10) {
                            Text(Description.dayDesc(activeDay))
                                .font(.custom(theme.font, size: 22))
                            
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
                
                VStack(spacing: 15) {
                    Text("\(Description.weatherDesc(activeDay == 0 ? nowWeather.text : (theme.isDaytime ? dailyWeather.textDay : dailyWeather.textNight)))")
                        .font(.custom(theme.font, size: 26))
                        .frame(maxWidth: 40)
                        .frame(height: 120)
                        
                    VStack(alignment: .center, spacing: 5) {
                        Text("\(dailyWeather.tempMax)°")
                            .font(.custom(theme.font, size: 14))
                        Divider().background(theme.backgroundColor).padding(.horizontal, 35)
                        Text("\(dailyWeather.tempMin)°")
                            .font(.custom(theme.font, size: 14))
                    }
                
                }
                .offset(y: 20)
                
                if activeDay == 1 {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text("呼和浩特")
                        }
                    }
                }
            }
        }
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
        .padding(.all, 10)
    }
}

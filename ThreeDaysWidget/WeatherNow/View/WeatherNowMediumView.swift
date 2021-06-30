//
//  WeatherNowMediumView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/26.
//

import WidgetKit
import SwiftUI

struct WeatherNowMediumView: View {
    @EnvironmentObject var theme: Theme
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceName: String?
    
    var body: some View {
        ZStack {
            theme.backgroundColor.opacity(0.2).ignoresSafeArea()
            
            if let dailyW = dailyWeather?.daily[0], let nowW = nowWeather?.now {
                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .center) {
                                Text("\(Description.weatherDesc(nowW.text))")
                                    .font(.custom(theme.font, size: 22))
                                Text("\(nowW.temp)°")
                                    .font(.custom(theme.font, size: 22))
                                
                                HStack(spacing: 5) {
                                    Text("\(dailyW.windDirDay)")
                                    Image(systemName: "circlebadge.fill")
                                        .font(.system(size: 6))
                                        .opacity(0.9)
                                    Text("\(dailyW.windSpeedDay)级")
                                }
                                .padding(.leading, 10)
                            }
                            
                            HStack(alignment: .center, spacing: 2) {
                                Image(systemName: "circle.lefthalf.fill")
                                    .font(.system(size: 10))
                                Text(activePlaceName ?? "未知")
                            }
                        }
                        
                        Spacer()
                        
                        
                        Text("今\n日")
                            .font(.custom(theme.font, size: 16))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    
                    Divider().background(theme.backgroundColor.opacity(0.1))
                    
                    HStack {
                        WeatherItem(
                            activeDay: 0,
                            nowWeather: nowWeather,
                            dailyWeather: dailyWeather,
                            activePlaceName: activePlaceName
                        )
                        .padding(.horizontal, 5)
                        
                        Divider().background(theme.backgroundColor.opacity(0.1))
                        
                        WeatherItem(
                            activeDay: 1,
                            nowWeather: nowWeather,
                            dailyWeather: dailyWeather,
                            activePlaceName: activePlaceName
                        )
                        .padding(.horizontal, 5)
                        
                        Divider().background(theme.backgroundColor.opacity(0.1))
                        
                        WeatherItem(
                            activeDay: 2,
                            nowWeather: nowWeather,
                            dailyWeather: dailyWeather,
                            activePlaceName: activePlaceName
                        )
                        .padding(.horizontal, 5)
                    }
                    .padding(.horizontal, 5)
                }
                
            }
        }
        .font(.custom(theme.font, size: 14))
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
    }
}

struct WeatherNowMediumView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowWidgetView(
            entry: WeatherEntry(
                date: Date(),
                nowWeather: WeatherNowModel(now: WeatherNowModel.Now(text: "多云", icon: "101", temp: "33", feelsLike: "35", wind360: "180", windDir: "南风", windSpeed: "14", humidity: "59", vis: "19"), code: "200", updateTime: "2021-06-25T11:52+08:00"),
                dailyWeather: WeatherDailyModel(daily: [WeatherDailyModel.Daily(fxDate: "2021-06-25", tempMax: "34", tempMin: "26", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "92", vis: "21", uvIndex: "10", moonPhase: "满月"), WeatherDailyModel.Daily(fxDate: "2021-06-26", tempMax: "35", tempMin: "27", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "90", vis: "24", uvIndex: "7", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-27", tempMax: "33", tempMin: "27", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "225", windDirNight: "西南风", windSpeedNight: "3", humidity: "96", vis: "17", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-28", tempMax: "28", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "307", textNight: "大雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "95", vis: "24", uvIndex: "3", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-29", tempMax: "29", tempMin: "24", iconDay: "306", textDay: "中雨", iconNight: "307", textNight: "大雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "94", vis: "14", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-30", tempMax: "26", tempMin: "25", iconDay: "307", textDay: "大雨", iconNight: "306", textNight: "中雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "97", vis: "20", uvIndex: "3", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-07-01", tempMax: "28", tempMin: "26", iconDay: "306", textDay: "中雨", iconNight: "305", textNight: "小雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "97", vis: "19", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-07-02", tempMax: "31", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "4", moonPhase: "下弦月"), WeatherDailyModel.Daily(fxDate: "2021-07-03", tempMax: "32", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "91", vis: "24", uvIndex: "4", moonPhase: "残月"), WeatherDailyModel.Daily(fxDate: "2021-07-04", tempMax: "31", tempMin: "24", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "315", windDirDay: "西北风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "3", moonPhase: "残月")], code: "200", updateTime: "2021-06-25T11:35+08:00"),
                activePlaceId: "101250101",
                activePlaceName: "长沙"
            )
        )
        .environmentObject(Theme())
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

private struct WeatherItem: View {
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
        if let dailyW = dailyWeather?.daily[activeDay], let nowW = nowWeather?.now {
            HStack(alignment: .top, spacing: 0) {
                VStack(spacing: 5) {
                    Text("\(Description.weatherDesc(activeDay == 0 ? nowW.text : (theme.isDaytime ? dailyW.textDay : dailyW.textNight)))")
                        .font(.custom(theme.font, size: 14))
                    
                    VStack(spacing: 2) {
                        Text("\(dailyW.tempMax)°")
                            .font(.custom(theme.font, size: 10))
                        
                        Divider().background(theme.backgroundColor.opacity(0.1)).padding(.horizontal, 15)
                       
                        Text("\(dailyW.tempMin)°")
                            .font(.custom(theme.font, size: 10))
                    }
                }
                
                Spacer()
                
                Text(Description.dayDesc(activeDay))
                    .font(.custom(theme.font, size: 12))
                    .padding(.trailing, 4)
                
                VStack(spacing: 0) {
                    Text("\(dateText.0)")
                    Text("月")
                    Text("\(dateText.1)")
                    Text("日")
                }
                .font(.custom(theme.font, size: 10))
            }
        }
    }
}

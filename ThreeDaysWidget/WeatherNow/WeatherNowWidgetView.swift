//
//  WeatherNowWidgetView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit
import SwiftUI

struct WeatherNowWidgetView: View {
    var entry: WidgetTimelineProvider.Entry
    @Environment(\.widgetFamily) private var family: WidgetFamily
    
    var body: some View {
        switch family {
            case .systemLarge:
                WidgetNotAvailableView()
            case .systemSmall:
                NowWeatherSmallView(nowWeather: entry.nowWeather, dailyWeather: entry.dailyWeather)
            case .systemMedium:
                NowWeatherMediumView()
            @unknown default:
                WidgetNotAvailableView()
        }
    }
}

struct NowWeatherSmallView: View {
    @EnvironmentObject var theme: Theme
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    
    var dateText: (Int, Int) {
        guard let daily = dailyWeather?.daily[0] else {
            return (1, 1)
        }
        
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[1])!, Int(temp[2])!)
    }
    
    var body: some View {
        ZStack {
            theme.backgroundColor.opacity(0.2).ignoresSafeArea()
            
            ZStack {
                if let dailyWeather = dailyWeather?.daily[0], let nowWeather = nowWeather?.now {
                    VStack {
                        HStack(alignment: .firstTextBaseline) {
                            Spacer()
                            
                            HStack(alignment: .top) {
                                Text("今\n日")
                                    .font(.custom(theme.font, size: 16))
                                
                                VStack(spacing: 0) {
                                    Image(systemName: "circle.righthalf.fill")
                                        .padding(.bottom, 2)
                                    
                                    Text("\(dateText.0)")
                                    Text("月")
                                    Text("\(dateText.1)")
                                    Text("日")
                                }
                                .font(.custom(theme.font, size: 10))
                                .offset(y: 10)
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
                            
                            Text("长沙")
                            
                            Spacer()
                        }
                    }
                    
                } else {
                    Text("nnn")
                }
            }
            .padding(.all, 10)
        }
        .font(.custom(theme.font, size: 14))
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
    }
}

struct NowWeatherMediumView: View {
    var body: some View {
        Text("Medium view")
    }
}


struct TempLimitView: View {
    @EnvironmentObject var theme: Theme
    var label: String
    var value: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("\(value)°")
                .font(.custom(theme.font, size: 12))
        }
    }
}


struct WeatherNowWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowWidgetView(
            entry: WeatherEntry(
                date: Date(),
                nowWeather: WeatherNowModel(now: WeatherNowModel.Now(text: "多云", icon: "101", temp: "33", feelsLike: "35", wind360: "180", windDir: "南风", windSpeed: "14", humidity: "59", vis: "19"), code: "200", updateTime: "2021-06-25T11:52+08:00"),
                dailyWeather: WeatherDailyModel(daily: [WeatherDailyModel.Daily(fxDate: "2021-06-25", tempMax: "34", tempMin: "26", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "92", vis: "21", uvIndex: "10", moonPhase: "满月"), WeatherDailyModel.Daily(fxDate: "2021-06-26", tempMax: "35", tempMin: "27", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "90", vis: "24", uvIndex: "7", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-27", tempMax: "33", tempMin: "27", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "225", windDirNight: "西南风", windSpeedNight: "3", humidity: "96", vis: "17", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-28", tempMax: "28", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "307", textNight: "大雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "95", vis: "24", uvIndex: "3", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-29", tempMax: "29", tempMin: "24", iconDay: "306", textDay: "中雨", iconNight: "307", textNight: "大雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "94", vis: "14", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-06-30", tempMax: "26", tempMin: "25", iconDay: "307", textDay: "大雨", iconNight: "306", textNight: "中雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "97", vis: "20", uvIndex: "3", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-07-01", tempMax: "28", tempMin: "26", iconDay: "306", textDay: "中雨", iconNight: "305", textNight: "小雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "97", vis: "19", uvIndex: "5", moonPhase: "亏凸月"), WeatherDailyModel.Daily(fxDate: "2021-07-02", tempMax: "31", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "154", textNight: "阴", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "4", moonPhase: "下弦月"), WeatherDailyModel.Daily(fxDate: "2021-07-03", tempMax: "32", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "91", vis: "24", uvIndex: "4", moonPhase: "残月"), WeatherDailyModel.Daily(fxDate: "2021-07-04", tempMax: "31", tempMin: "24", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "315", windDirDay: "西北风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "3", moonPhase: "残月")], code: "200", updateTime: "2021-06-25T11:35+08:00")
            )
        )
        .environmentObject(Theme())
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


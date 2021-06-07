//
//  WeatherDetailView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/2.
//

import SwiftUI

struct WeatherDetailView: View {
    @EnvironmentObject var theme: Theme
    @Binding var showWeatherDetail: Bool
    @EnvironmentObject var viewModel: WeatherViewModel

    var tempViewModel: WeatherHourlyModel = WeatherHourlyModel(hourly: [WeatherHourlyModel.Hourly(fxTime: "2021-06-03T14:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "360", windDir: "北风", windScale: "3-4", windSpeed: "18", humidity: "88", pop: "20", precip: "0.0", pressure: "1007", cloud: "100", dew: "20"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T15:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "360", windDir: "北风", windScale: "3-4", windSpeed: "18", humidity: "87", pop: "20", precip: "0.0", pressure: "1007", cloud: "100", dew: "21"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T16:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "359", windDir: "北风", windScale: "3-4", windSpeed: "20", humidity: "82", pop: "20", precip: "0.0", pressure: "1006", cloud: "100", dew: "20"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T17:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "356", windDir: "北风", windScale: "3-4", windSpeed: "20", humidity: "72", pop: "20", precip: "0.0", pressure: "1006", cloud: "100", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T18:00+08:00", temp: "22", icon: "101", text: "多云", wind360: "347", windDir: "西北风", windScale: "3-4", windSpeed: "18", humidity: "69", pop: "25", precip: "0.0", pressure: "1005", cloud: "100", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T19:00+08:00", temp: "22", icon: "305", text: "小雨", wind360: "337", windDir: "西北风", windScale: "3-4", windSpeed: "18", humidity: "70", pop: "53", precip: "0.3", pressure: "1005", cloud: "100", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T20:00+08:00", temp: "22", icon: "305", text: "小雨", wind360: "325", windDir: "西北风", windScale: "3-4", windSpeed: "16", humidity: "74", pop: "53", precip: "0.3", pressure: "1005", cloud: "100", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T21:00+08:00", temp: "21", icon: "101", text: "多云", wind360: "322", windDir: "西北风", windScale: "3-4", windSpeed: "14", humidity: "81", pop: "49", precip: "0.0", pressure: "1004", cloud: "99", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T22:00+08:00", temp: "21", icon: "101", text: "多云", wind360: "328", windDir: "西北风", windScale: "3-4", windSpeed: "14", humidity: "82", pop: "47", precip: "0.0", pressure: "1005", cloud: "99", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T23:00+08:00", temp: "20", icon: "305", text: "小雨", wind360: "337", windDir: "西北风", windScale: "3-4", windSpeed: "13", humidity: "82", pop: "51", precip: "0.3", pressure: "1005", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T00:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "338", windDir: "西北风", windScale: "3-4", windSpeed: "13", humidity: "81", pop: "47", precip: "0.0", pressure: "1005", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T01:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "341", windDir: "西北风", windScale: "1-2", windSpeed: "11", humidity: "81", pop: "20", precip: "0.0", pressure: "1005", cloud: "99", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T02:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "343", windDir: "西北风", windScale: "1-2", windSpeed: "11", humidity: "80", pop: "20", precip: "0.0", pressure: "1005", cloud: "100", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T03:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "343", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "78", pop: "20", precip: "0.0", pressure: "1005", cloud: "99", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T04:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "343", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "84", pop: "20", precip: "0.0", pressure: "1004", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T05:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "345", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "84", pop: "20", precip: "0.0", pressure: "1004", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T06:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "344", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "83", pop: "13", precip: "0.0", pressure: "1003", cloud: "97", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T07:00+08:00", temp: "21", icon: "101", text: "多云", wind360: "271", windDir: "西风", windScale: "1-2", windSpeed: "7", humidity: "83", pop: "0", precip: "0.0", pressure: "1002", cloud: "95", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T08:00+08:00", temp: "22", icon: "101", text: "多云", wind360: "256", windDir: "西南风", windScale: "1-2", windSpeed: "5", humidity: "80", pop: "0", precip: "0.0", pressure: "1002", cloud: "94", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T09:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "263", windDir: "西风", windScale: "1-2", windSpeed: "5", humidity: "70", pop: "0", precip: "0.0", pressure: "1001", cloud: "94", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T10:00+08:00", temp: "25", icon: "101", text: "多云", wind360: "283", windDir: "西北风", windScale: "1-2", windSpeed: "5", humidity: "60", pop: "0", precip: "0.0", pressure: "1001", cloud: "94", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T11:00+08:00", temp: "26", icon: "101", text: "多云", wind360: "292", windDir: "西北风", windScale: "1-2", windSpeed: "7", humidity: "53", pop: "0", precip: "0.0", pressure: "1001", cloud: "93", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T12:00+08:00", temp: "26", icon: "101", text: "多云", wind360: "291", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "50", pop: "0", precip: "0.0", pressure: "1001", cloud: "90", dew: "15"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T13:00+08:00", temp: "27", icon: "101", text: "多云", wind360: "288", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "49", pop: "0", precip: "0.0", pressure: "1002", cloud: "86", dew: "15")], code: "200", updateTime: "2021-06-03T13:35+08:00")
    
    let isDebug = true
    var hourlyModel: WeatherHourlyModel {
        let realViewModel = viewModel.weatherHourly ?? tempViewModel
        return !isDebug ? realViewModel : tempViewModel
    }
    
    func timeString(_ dateStr: String, format: String = "HH") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+8")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        
        var result = ""
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = format
            result = formatter.string(from: date)
        }
    
        return result
    }
    
    var currentDate : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        let result = formatter.string(from: Date())
        return result
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("24小时天气预报")
                    Spacer()
                    
                    Button(action: {
                        showWeatherDetail.toggle()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 30)
                
                if let hourly = hourlyModel.hourly {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(hourly.indices) { index in
                                if let item = hourly[index], let hour = timeString(item.fxTime), let day = timeString(item.fxTime, format: "MM-dd") {
                                    VStack(spacing: 10) {
                                        if hour != "00" {
                                            Text("\(hour)时")
                                        } else {
                                            Text("明日")
                                        }

                                        Group {
                                            Image(systemName: "\(Description.weatherSystemIcon(item.icon))")
                                                .font(.system(size: 26))
                                        }
                                        .frame(height: 50)

                                        Text("\(item.temp)°")
                                            .font(.custom(theme.font, size: 24))
                                    }
                                    .padding(20)
                                    .background(currentDate == day ? theme.backgroundColor.opacity(1) : Color.white)
                                    .foregroundColor(currentDate == day ? Color.white : theme.textColor)
                                    .cornerRadius(50)
                                    .shadow(color: theme.textColor.opacity(0.2), radius: 3, x: 0, y:  10)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
                                }
                            }
                        
                        }
                        .font(.custom(theme.font, size: 18))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 30)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.vertical, 60)
        .foregroundColor(theme.textColor)
        .font(.custom(theme.font, size: 24))
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemMaterial).background(theme.backgroundColor.opacity(0.4)))
        .ignoresSafeArea()
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(
            showWeatherDetail: .constant(true)
        )
        .environmentObject(Theme())
        .environmentObject(WeatherViewModel())
        .environmentObject(PlaceListViewModel())
    }
}

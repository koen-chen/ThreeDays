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

    var tempHourlyModel: WeatherHourlyModel = WeatherHourlyModel(hourly: [WeatherHourlyModel.Hourly(fxTime: "2021-06-03T14:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "360", windDir: "北风", windScale: "3-4", windSpeed: "18", humidity: "88", pop: "20", precip: "0.0", pressure: "1007", cloud: "100", dew: "20"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T15:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "360", windDir: "北风", windScale: "3-4", windSpeed: "18", humidity: "87", pop: "20", precip: "0.0", pressure: "1007", cloud: "100", dew: "21"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T16:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "359", windDir: "北风", windScale: "3-4", windSpeed: "20", humidity: "82", pop: "20", precip: "0.0", pressure: "1006", cloud: "100", dew: "20"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T17:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "356", windDir: "北风", windScale: "3-4", windSpeed: "20", humidity: "72", pop: "20", precip: "0.0", pressure: "1006", cloud: "100", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T18:00+08:00", temp: "22", icon: "101", text: "多云", wind360: "347", windDir: "西北风", windScale: "3-4", windSpeed: "18", humidity: "69", pop: "25", precip: "0.0", pressure: "1005", cloud: "100", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T19:00+08:00", temp: "22", icon: "305", text: "小雨", wind360: "337", windDir: "西北风", windScale: "3-4", windSpeed: "18", humidity: "70", pop: "53", precip: "0.3", pressure: "1005", cloud: "100", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T20:00+08:00", temp: "22", icon: "305", text: "小雨", wind360: "325", windDir: "西北风", windScale: "3-4", windSpeed: "16", humidity: "74", pop: "53", precip: "0.3", pressure: "1005", cloud: "100", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T21:00+08:00", temp: "21", icon: "101", text: "多云", wind360: "322", windDir: "西北风", windScale: "3-4", windSpeed: "14", humidity: "81", pop: "49", precip: "0.0", pressure: "1004", cloud: "99", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T22:00+08:00", temp: "21", icon: "101", text: "多云", wind360: "328", windDir: "西北风", windScale: "3-4", windSpeed: "14", humidity: "82", pop: "47", precip: "0.0", pressure: "1005", cloud: "99", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-03T23:00+08:00", temp: "20", icon: "305", text: "小雨", wind360: "337", windDir: "西北风", windScale: "3-4", windSpeed: "13", humidity: "82", pop: "51", precip: "0.3", pressure: "1005", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T00:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "338", windDir: "西北风", windScale: "3-4", windSpeed: "13", humidity: "81", pop: "47", precip: "0.0", pressure: "1005", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T01:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "341", windDir: "西北风", windScale: "1-2", windSpeed: "11", humidity: "81", pop: "20", precip: "0.0", pressure: "1005", cloud: "99", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T02:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "343", windDir: "西北风", windScale: "1-2", windSpeed: "11", humidity: "80", pop: "20", precip: "0.0", pressure: "1005", cloud: "100", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T03:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "343", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "78", pop: "20", precip: "0.0", pressure: "1005", cloud: "99", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T04:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "343", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "84", pop: "20", precip: "0.0", pressure: "1004", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T05:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "345", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "84", pop: "20", precip: "0.0", pressure: "1004", cloud: "99", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T06:00+08:00", temp: "20", icon: "101", text: "多云", wind360: "344", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "83", pop: "13", precip: "0.0", pressure: "1003", cloud: "97", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T07:00+08:00", temp: "21", icon: "101", text: "多云", wind360: "271", windDir: "西风", windScale: "1-2", windSpeed: "7", humidity: "83", pop: "0", precip: "0.0", pressure: "1002", cloud: "95", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T08:00+08:00", temp: "22", icon: "101", text: "多云", wind360: "256", windDir: "西南风", windScale: "1-2", windSpeed: "5", humidity: "80", pop: "0", precip: "0.0", pressure: "1002", cloud: "94", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T09:00+08:00", temp: "23", icon: "101", text: "多云", wind360: "263", windDir: "西风", windScale: "1-2", windSpeed: "5", humidity: "70", pop: "0", precip: "0.0", pressure: "1001", cloud: "94", dew: "18"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T10:00+08:00", temp: "25", icon: "101", text: "多云", wind360: "283", windDir: "西北风", windScale: "1-2", windSpeed: "5", humidity: "60", pop: "0", precip: "0.0", pressure: "1001", cloud: "94", dew: "17"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T11:00+08:00", temp: "26", icon: "101", text: "多云", wind360: "292", windDir: "西北风", windScale: "1-2", windSpeed: "7", humidity: "53", pop: "0", precip: "0.0", pressure: "1001", cloud: "93", dew: "16"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T12:00+08:00", temp: "26", icon: "101", text: "多云", wind360: "291", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "50", pop: "0", precip: "0.0", pressure: "1001", cloud: "90", dew: "15"), WeatherHourlyModel.Hourly(fxTime: "2021-06-04T13:00+08:00", temp: "27", icon: "101", text: "多云", wind360: "288", windDir: "西北风", windScale: "1-2", windSpeed: "9", humidity: "49", pop: "0", precip: "0.0", pressure: "1002", cloud: "86", dew: "15")], code: "200", updateTime: "2021-06-03T13:35+08:00")
    var tempDailyModel: WeatherDailyModel = WeatherDailyModel(daily: [WeatherDailyModel.Daily(fxDate: "2021-06-10", tempMax: "29", tempMin: "22", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "346", windDirDay: "西北风", windSpeedDay: "9", wind360Night: "90", windDirNight: "东风", windSpeedNight: "3", humidity: "97", vis: "13", uvIndex: "4", moonPhase: "新月"), WeatherDailyModel.Daily(fxDate: "2021-06-11", tempMax: "28", tempMin: "22", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "45", windDirDay: "东北风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "92", vis: "24", uvIndex: "4", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-12", tempMax: "32", tempMin: "25", iconDay: "305", textDay: "小雨", iconNight: "101", textNight: "多云", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "135", windDirNight: "东南风", windSpeedNight: "3", humidity: "91", vis: "24", uvIndex: "8", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-13", tempMax: "32", tempMin: "27", iconDay: "101", textDay: "多云", iconNight: "101", textNight: "多云", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "87", vis: "24", uvIndex: "8", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-14", tempMax: "35", tempMin: "28", iconDay: "101", textDay: "多云", iconNight: "101", textNight: "多云", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "83", vis: "25", uvIndex: "12", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-15", tempMax: "35", tempMin: "27", iconDay: "101", textDay: "多云", iconNight: "101", textNight: "多云", wind360Day: "135", windDirDay: "东南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "55", vis: "25", uvIndex: "6", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-16", tempMax: "36", tempMin: "28", iconDay: "101", textDay: "多云", iconNight: "101", textNight: "多云", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "180", windDirNight: "南风", windSpeedNight: "3", humidity: "78", vis: "25", uvIndex: "6", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-17", tempMax: "36", tempMin: "25", iconDay: "104", textDay: "阴", iconNight: "305", textNight: "小雨", wind360Day: "180", windDirDay: "南风", windSpeedDay: "3", wind360Night: "225", windDirNight: "西南风", windSpeedNight: "3", humidity: "94", vis: "8", uvIndex: "6", moonPhase: "峨眉月"), WeatherDailyModel.Daily(fxDate: "2021-06-18", tempMax: "30", tempMin: "23", iconDay: "305", textDay: "小雨", iconNight: "305", textNight: "小雨", wind360Day: "0", windDirDay: "北风", windSpeedDay: "3", wind360Night: "0", windDirNight: "北风", windSpeedNight: "3", humidity: "94", vis: "15", uvIndex: "3", moonPhase: "上弦月"), WeatherDailyModel.Daily(fxDate: "2021-06-19", tempMax: "27", tempMin: "21", iconDay: "104", textDay: "阴", iconNight: "305", textNight: "小雨", wind360Day: "315", windDirDay: "西北风", windSpeedDay: "3", wind360Night: "0", windDirNight: "北风", windSpeedNight: "3", humidity: "92", vis: "20", uvIndex: "3", moonPhase: "盈凸月")], code: "200", updateTime: "2021-06-10T21:35+08:00")
    
    var hourlyModel: WeatherHourlyModel {
        return viewModel.weatherHourly ?? tempHourlyModel
    }
    
    var dailyModel: WeatherDailyModel {
        return viewModel.weatherDaily ?? tempDailyModel
    }
    
    func timeString(_ dateStr: String, format: String = "HH:mm") -> String {
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
    
    let hourlyWidth: CGFloat = 60
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("未来24小时预报")
                        Spacer()
                        
                        Button(action: {
                            showWeatherDetail.toggle()
                        }) {
                            Image(systemName: "xmark")
                        }
                    }
                    .padding(.bottom, 10)
                   
                    
                    if let hourly = hourlyModel.hourly {
                        ScrollView(.horizontal, showsIndicators: false) {
                            drawGrid(hourly)
                                .overlay(drawLine(hourly))
                                .overlay(drawPoints(hourly))
                                .overlay(drawWindInfo(hourly))
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading) {
                    Text("未来10日预报")
                    
                    if let daily = dailyModel.daily {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(daily.indices) { index in
                                    Day15Item(item: daily[index])
                                    Divider().background(theme.backgroundColor).padding(.vertical, 5)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 20)

                
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
    
    func drawGrid(_ hourly: [WeatherHourlyModel.Hourly]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(hourly.indices) { i in
                    VStack(spacing: 5) {
                        theme.textColor
                            .opacity(0.4)
                            .frame(width: 1, height: 5, alignment: .center)
                        if let hour = timeString(hourly[i].fxTime) {
                            if hour != "00:00" {
                                Text("\(hour)")
                            } else {
                                Text("明日")
                            }
                        }
                    }
                    .frame(width: hourlyWidth)
                    .font(.system(size: 14))
                    .foregroundColor(theme.textColor)
                    
                }
            }
            
            theme.textColor.opacity(0.4)
                .frame(height: 1, alignment: .center)
                .offset(y: -28)
        }
        .frame(width:CGFloat(hourly.count) * hourlyWidth, height: 280)
        .opacity(0.9)
           
    }
    
    func drawLine(_ hourly: [WeatherHourlyModel.Hourly]) -> some View {
        return GeometryReader { geo in
            Path { p in
                let scale = getScale(hourly, geo: geo)
                var index: CGFloat = 0
                
                p.move(to: CGPoint(x: hourlyWidth / 2, y: geo.size.height - (CGFloat(Int(hourly[0].temp) ?? 0) * scale)))
            
                for _ in hourly {
                    if index != 0 {
                        p.addLine(to: CGPoint(x: hourlyWidth / 2 + ((geo.size.width - hourlyWidth) / 23) * index, y: geo.size.height - (CGFloat(Int(hourly[Int(index)].temp) ?? 0) * scale)))
                    }
                    
                    index += 1
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .square, lineJoin: .round))
            .foregroundColor(theme.textColor.opacity(0.8))
           
        }
    }
    
    func drawWindInfo (_ hourly: [WeatherHourlyModel.Hourly]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(hourly.indices) { i in
                    VStack(spacing: 10) {
                        Text("\(hourly[i].windDir)")
                        Text("\(hourly[i].windScale)级")
                    }
                    .frame(width: hourlyWidth)
                    .font(.system(size: 14))
                    .foregroundColor(theme.textColor)
                }
            }
        }
        .frame(width:CGFloat(hourly.count) * hourlyWidth)
        .opacity(0.9)
        .offset(y: -45)
    }
    
    func drawPoints(_ hourly: [WeatherHourlyModel.Hourly]) -> some View {
        GeometryReader { geo in
            let scale = getScale(hourly, geo: geo)
            
            ForEach(hourly.indices) { i in
                if let item = hourly[i], let temp = item.temp {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(theme.textColor.opacity(0.8))
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            VStack(spacing: 10) {
                                if let pop = item.pop, Int(pop) != 0 {
                                   Text("\(pop)%")
                                        .opacity(0.7)
                                        .font(.system(size: 12, weight: .bold, design: .default))
                                }
                                
                                VStack(spacing: 20) {
                                    Image(systemName: "\(Description.weatherSystemIcon(item.icon))")
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                    Text("\(temp)°")
                                }
                            }
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .frame(width: 50)
                            .offset(y: -60)
                        )
                        .offset(x: hourlyWidth / 2 + ((geo.size.width - hourlyWidth) / 23) * CGFloat(i) - 5, y: (geo.size.height - (CGFloat(Int(temp) ?? 0) * scale)) - 5)
                }
            }
        }
    }
    
    func getScale (_ hourly: [WeatherHourlyModel.Hourly], geo: GeometryProxy) -> CGFloat {
        let maxTemp = hourly.reduce(0) { res, item in
            return max(res, Int(item.temp) ?? 0)
        }
        
        let scale = maxTemp == 0 ? 1 : (geo.size.height - 120) / CGFloat(maxTemp)
        
        return scale
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

struct Day15Item: View {
    @EnvironmentObject var theme: Theme
    var item: WeatherDailyModel.Daily
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(item.fxDate.weekdayFormater())
                Text(item.fxDate)
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            Text(Description.weatherDesc(item.textDay))
            
            Spacer()
            
            HStack {
                Text("\(item.tempMin)°")
                Text("/")
                Text("\(item.tempMax)°")
            }
            .font(.system(size: 14))
        }
        .font(.custom(theme.font, size: 16))
    }
}

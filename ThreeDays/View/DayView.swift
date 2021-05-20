//
//  TodayView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/14.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var weatherStore: WeatherViewModel
    
    var activeDay: Int
    var placeCity: String
    
    @Binding var showDayList: Bool
    @Binding var showCityList: Bool
    
    var dailyText: String {
        switch activeDay {
            case 0:
                return "今\n日"
            case 1:
                return "明\n日"
            case 2:
                return "后\n日"
            default:
                return ""
        }
    }
    
    var nowWeather: WeatherModel.Now {
        return weatherStore.weather.result.now ?? WeatherModel.Now()
    }
    
    var dailyWeather: WeatherModel.Forecasts {
        return weatherStore.weather.result.forecasts?[self.activeDay] ?? WeatherModel.Forecasts()
    }
    
    var weatherDesc: String {
        let text = theme.isDaytime ? dailyWeather.text_day : dailyWeather.text_night
        switch text {
            case "雷阵雨伴有冰雹":
                return "雷阵雨"
            case "大暴雨", "大到暴雨", "暴雨到大暴雨", "大暴雨到特大暴雨", "特大暴雨":
                return "暴雨"
            case "小到中雨":
                return "中雨"
            case "中到大雨":
                return "大雨"
            case "小到中雪":
                return "中雪"
            case "中到大雪":
                return "大雪"
            case "大到暴雪":
                return "暴雪"
            case "强沙尘暴":
                return "沙尘暴"
            case "特强浓雾":
                return "强浓雾"
            case "弱高吹雪":
                return "高吹雪"
            default:
                return text
        }
    }

    var dateText: (Int, Int) {
        guard dailyWeather.date.count != 0 else {
            return (1, 1)
        }
        let temp = dailyWeather.date.components(separatedBy: "-")
        
        return (Int(temp[1])!, Int(temp[2])!)
    }
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }
    
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }
    
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    
                    HStack(alignment: .lastTextBaseline) {
                        Text(dailyText)
                            .font(.custom("SourceHanSerif-SemiBold", size: 42))

                        VStack {
                            Image(systemName: "circle.righthalf.fill")
                                .padding(.bottom, 2)
                               
                            Text("\(dateText.0)")
                            Text("月")
                            Text("\(dateText.1)")
                            Text("日")
                        }
                        .font(.custom("SourceHanSerif-SemiBold", size: 14))
                        .offset(y: 40)
                        .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                    }
                    .padding(.top, 30)
                    .padding(.trailing, 20)
                    .onTapGesture(perform: {
                        self.showDayList.toggle()
                    })
                }
                
                Spacer()
            }
            
            VStack(alignment: .center, spacing: 15) {
                VStack {
                    LottieView(isWeather: true, weatherDesc: weatherDesc)
                        .frame(width: 180, height: 180)
                        .padding(.bottom, 20)
                }
                
                VStack(alignment: .center, spacing: 15) {
                    Text("\(weatherDesc)")
                        .font(.custom("ZhuoJianGanLanJianTi-Regular", size: 66))
                    
                    if activeDay == 0 {
                        ZStack(alignment: .bottom) {
                            Text("\(nowWeather.temp)°")
                                .font(.custom("SourceHanSerif-SemiBold", size: 66))
                                .offset(x: 10)
                            
                            Text("\(timeString(date: currentDate))")
                                .onReceive(timer) { input in
                                    currentDate = input
                                }
                                .font(.system(size: 14))
                                .offset(x: 80, y: -15)
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 20) {
                        Text("最低 \(dailyWeather.low)°")
                        Text("最高 \(dailyWeather.high)°")
                    }
                    .font(.custom("SourceHanSerif-SemiBold", size: 18))
                    .padding(.top, 30)
                    .offset(x: 5)
                }
            }
            .offset(y: -20)
            

            VStack {
                Spacer()
                
                Button(action: {
                    showCityList.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "circle.lefthalf.fill")
                        Text(placeCity)
                            .font(.custom("SourceHanSerif-SemiBold", size: 24))
                        
                        Spacer()
                    }
                })
               
            }
            .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(activeDay: 0, placeCity: "长沙市", showDayList: .constant(false), showCityList: .constant(false))
            .environmentObject(Theme())
            .environmentObject(WeatherViewModel())
    }
}

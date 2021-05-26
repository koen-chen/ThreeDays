//
//  WeatherView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/14.
//

import SwiftUI

//let screen = UIScreen.main.bounds

struct WeatherView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var weatherStore: WeatherViewModel
    
    var activeDay: Int
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
       // formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "H:mm"
//        formatter.amSymbol = "am"
//        formatter.pmSymbol = "pm"
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
                        .font(.custom("ZhuoJianGanLanJianTi-Regular", size: 66))
                    
                    if activeDay == 0 {
                        ZStack(alignment: .bottom) {
                            Text("\(nowWeather.temp)°")
                                .font(.custom("SourceHanSerif-SemiBold", size: 66))
                                .offset(x: 10)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                Text("\(timeString(date: currentDate))")
                            }
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
                    .padding(.top, screen.height < 800 ? 0 : 30)
                    .offset(x: 5)
                }
            }
            .offset(y: -20)
            
            CityView(showCityList: $showCityList)
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
            .environmentObject(PlaceViewModel())
    }
}

struct DayView: View {
    var dailyText: String
    var dateText: (Int, Int)
    @Binding var showDayList: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                HStack(alignment: .lastTextBaseline) {
                    Text(dailyText)
                        .font(.custom("SourceHanSerif-SemiBold", size: 42))
                    
                    VStack {
                        Button(action: {
                            self.showDayList.toggle()
                        }, label: {
                            Image(systemName: "circle.righthalf.fill")
                                .rotationEffect(Angle.degrees(self.showDayList ? 180 : 0))
                                .padding(.bottom, 2)
                        })
                        

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
    }
}

struct CityView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var placeStore: PlaceViewModel
    @Binding var showCityList: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {
                    showCityList.toggle()
                }, label: {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "circle.lefthalf.fill")
                            .rotationEffect(Angle.degrees(self.showCityList ? 180 : 0))
                            .offset(y: -4)
                        
                        if let district = placeStore.activePlace?.district,
                           let city = placeStore.activePlace?.city,
                           (district == city.dropLast() || district == city){
                            VStack(alignment: .leading, spacing: 5) {
                                Text(district)
                                Text(placeStore.activePlace?.province ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(theme.textColor.opacity(0.8))
                            }.font(.custom("SourceHanSerif-SemiBold", size: 24))
                        } else {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(placeStore.activePlace?.district ?? "")
                                Text(placeStore.activePlace?.city ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(theme.textColor.opacity(0.8))
                            }.font(.custom("SourceHanSerif-SemiBold", size: 22))
                        }
                    }
                })
                
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, screen.height < 800 ? 10 : 30)
    }
}

//
//  WeatherView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/14.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var activeDay: Int = 0
    @Binding var showDayList: Bool
    @Binding var showCityList: Bool
    @Binding var showWeatherDetail: Bool
    @Binding var showDailyPreview: Bool
    @Binding var showProfileView: Bool
    
    @State var showWarning: Bool = false
    @State var showAlert: Bool = false
    @State var alertContent: String = ""
   
    func getAlertColor(_ text: String) -> Color {
        switch text {
            case "红色":
                return Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
            case "橙色":
                return Color(#colorLiteral(red: 1, green: 0.4487476945, blue: 0, alpha: 1))
            case "黄色":
                return Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
            case "蓝色":
                return Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
            default:
                return Color.white
        }
    }
    
    var dateText: (Int, Int, Int) {
        guard let daily = viewModel.weatherDaily?.daily[self.activeDay] else {
            return (0, 0, 0)
        }
   
        let temp = daily.fxDate.components(separatedBy: "-")
        
        return (Int(temp[0])!, Int(temp[1])!, Int(temp[2])!)
    }
    
    func animateAndDelayWithSeconds(_ seconds: TimeInterval, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            withAnimation {
                action()
            }
        }
    }
    
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
            
            if let weatherWarning = viewModel.weatherWarning?.warning, activeDay == 0 {
                VStack(spacing: 10) {
                    ForEach(weatherWarning.indices, id: \.self) { index in
                        if showWarning, !showDailyPreview, let item = weatherWarning[index], let alertColor = getAlertColor(item.level) {
                            Button(action: {
                                alertContent = item.text
                                showAlert.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "exclamationmark.circle")
                                        .foregroundColor(alertColor)
                                    Text(item.typeName)
                                        .font(.system(size: 14))
                                }
                                .padding(.vertical, 6)
                                .padding(.horizontal, 20)
                                .cornerRadius(6)
                                .background(alertColor.opacity(0.1))
                                .foregroundColor(alertColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6).stroke(alertColor.opacity(0.6), lineWidth: 1)
                                )
                            }
                            .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                            .alert(isPresented: $showAlert, content: {
                                Alert(
                                    title: Text(alertContent),
                                    dismissButton: .default(Text("OK"))
                                )
                            })
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 40)
                .onAppear {
                    self.animateAndDelayWithSeconds(2) {
                        self.showWarning = true
                    }
                }
            }
           
            HStack(alignment: showDailyPreview ? .center : .firstTextBaseline) {
                if !showDailyPreview {
                    Button(action: {
                        self.showProfileView.toggle()
                    }, label: {
                        Image(systemName: "circle.bottomhalf.fill")
                            .font(.system(size: 18))
                            .padding(.all, 30)
                            .offset(y: 15)
                    })
                    
                    Spacer()
                }
                
                DayView(
                    dailyText: Description.dayDesc(activeDay),
                    dateText: dateText,
                    showDayList: showDailyPreview ? .constant(false) : $showDayList
                )
                .font(.custom(theme.font, size: showDailyPreview ? 38 : 40))
            }
            
            
            if let dailyWeather = viewModel.weatherDaily?.daily[self.activeDay], let nowWeather = viewModel.weatherNow?.now {
                VStack(alignment: .center, spacing: 15) {
                    if !showDailyPreview {
                        VStack {
                            LottieView(
                                isWeather: true,
                                weatherCode: activeDay == 0 ? nowWeather.icon : (theme.isDaytime ? dailyWeather.iconDay : dailyWeather.iconNight)
                            )
                            .frame(width: 160, height: 160)
                            .padding(.bottom, 10)
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(Description.weatherDesc(activeDay == 0 ? nowWeather.text : (theme.isDaytime ? dailyWeather.textDay : dailyWeather.textNight)))")
                            .font(.custom(theme.font, size: showDailyPreview ? 48 : 62))
                            .frame(maxWidth: showDailyPreview ? 60 : .infinity)
                            .frame(height: showDailyPreview ? 240 : nil)
                        
                        if !showDailyPreview, activeDay == 0 {
                            Text("\(nowWeather.temp)°")
                                .font(.custom(theme.font, size: 60))
                                .offset(x: 10)
                        }
                        
                        if showDailyPreview {
                            VStack(alignment: .center, spacing: 10) {
                                TempLimitView(label: "", value: dailyWeather.tempMax)
                                Divider().background(theme.backgroundColor).padding(.horizontal, 30)
                                TempLimitView(label: "", value: dailyWeather.tempMin)
                            }
                            
                            VStack(spacing: 10) {
                                Text("\(dailyWeather.windDirDay)")
                                Text("\(dailyWeather.windSpeedDay)级")
                            }
                            .padding(.top, 50)
                        } else {
                            HStack(alignment: .center, spacing: 20) {
                                TempLimitView(label: "最低", value: dailyWeather.tempMin)
                                TempLimitView(label: "最高", value: dailyWeather.tempMax)
                            }
                            .padding(.top, 15)
                        }
                    }
                }
                .offset(y: -20)
                .padding(.top, showDailyPreview ? 60 : 0)
                .padding(.bottom, showDailyPreview ? 20 : 0)
                .onTapGesture(perform: {
                    if !showDailyPreview {
                        self.showWeatherDetail.toggle()
                    }
                })
            } else {
                LottieView(name: "loading2-\(theme.iconText)")
                    .frame(width: 300, height: 300)
                    .padding()
            }
            
            if !showDailyPreview {
                PlaceView(showCityList: $showCityList)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
 
    }
}


extension AnyTransition {
    static var fadeAndSlide: AnyTransition {
        AnyTransition.move(edge: .top).combined(with: opacity)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(
            activeDay: 0,
            showDayList: .constant(false),
            showCityList: .constant(false),
            showWeatherDetail: .constant(false),
            showDailyPreview: .constant(false),
            showProfileView: .constant(false)
        )
        .environmentObject(Theme())
        .environmentObject(WeatherViewModel())
        .environmentObject(PlaceListViewModel())
    }
}

struct TempLimitView: View {
    @EnvironmentObject var theme: Theme
    var label: String
    var value: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("\(label)")
                .font(.custom(theme.font, size: 16))
                .opacity(0.9)
            
            Text("\(value)°")
                .font(.custom(theme.font, size: 20))
        }
        .offset(x: label.count > 0 ? 5 : 0)
    }
}

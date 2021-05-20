//
//  CityView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/17.
//

import SwiftUI

struct CityListView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var weatherStore: WeatherViewModel
    
    @Binding var showCityList: Bool
    @Binding var activeCity: String?
    
    struct City: Identifiable {
        var id = UUID()
        var name: String
        var adcode: String
    }
    
    let cityList = [
        City(name: "长沙市", adcode: "430104"),
        City(name: "岳阳市", adcode: "430602"),
        City(name: "北京市", adcode: "110101"),
        City(name: "呼和浩特市", adcode: "150102"),
        City(name: "深圳市", adcode: "440304"),
        City(name: "齐齐哈尔市", adcode: "230203")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .firstTextBaseline, spacing: 40) {
                    ForEach(cityList) { item in
                        if item.name.count > 6 {
                            Button(action: {
                                chooseCity(item)
                            }, label: {
                                HStack(alignment: .firstTextBaseline, spacing: 2) {
                                    Text(item.name[item.name.index(item.name.startIndex, offsetBy: 6)...])
                                        .frame(width: 34)
                                    Text(item.name[..<item.name.index(item.name.startIndex, offsetBy: 6)])
                                        .frame(width: 34)
                                }
                            })

                        } else {
                            Button(action: {
                                chooseCity(item)
                            }, label: {
                                Text(item.name)
                                    .frame(width: 34)
                            })
                        }
                    }
                }
                .font(.custom("SourceHanSerif-SemiBold", size: 28))
                .foregroundColor(theme.textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .padding(.horizontal, 15)
                .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
            }
            .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
            .cornerRadius(30)
            .padding(.horizontal, 10)
            .padding(.vertical, 30)
            .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
        }
    }
    
    func chooseCity (_ city: City) {
        activeCity = city.name
        weatherStore.getWeather(districtId: city.adcode)
        showCityList.toggle()
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(showCityList: .constant(true), activeCity: .constant("430104"))
            .environmentObject(Theme())
            .environmentObject(WeatherViewModel())
    }
}

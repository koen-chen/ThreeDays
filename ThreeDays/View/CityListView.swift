//
//  CityListView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/17.
//

import SwiftUI
import CoreData

struct CityListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Place.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Place.isAppLocation, ascending: false),
            NSSortDescriptor(keyPath: \Place.createdAt, ascending: false)
        ]
    ) var placeList: FetchedResults<Place>
    
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var placeStore: PlaceViewModel
    @EnvironmentObject var weatherStore: WeatherViewModel
    
    @Binding var showCityList: Bool
    @State var showRemoveBtn: Bool = false
    @State var showCitySearchView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                HStack {
                    Button(action: {
                        self.showCitySearchView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                    .fullScreenCover(isPresented: $showCitySearchView) {
                       CitySearchView()
                        .environmentObject(theme)
                        .environmentObject(placeStore)
                    }

                    Spacer()

                    Button(action: {
                        self.showRemoveBtn.toggle()
                    }, label: {
                        Image(systemName: showRemoveBtn ? "checkmark.circle" : "minus.circle")
                    })
                }
                .font(.system(size: 28))
                .foregroundColor(theme.textColor)
                .padding(.horizontal, 22)
                .padding(.trailing, 6)
                .padding(.bottom, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .firstTextBaseline, spacing: 40) {
                        ForEach(placeList) { item in
                            VStack {
                                if showRemoveBtn {
                                    Button(action: {
                                        if !item.isAppLocation {
                                            self.removeCity(item)
                                        }
                                    }, label: {
                                        Image(systemName: item.isAppLocation ? "location.circle" : "xmark.circle")
                                    })
                                    .font(.system(size: 24))
                                    .padding(.bottom, 2)
                                }

                                Button(action: {
                                    chooseCity(item)
                                }, label: {
                                    if let district = item.district,
                                       let city = item.city,
                                       district == city.dropLast() {
                                        HStack(alignment: .firstTextBaseline) {
                                            Text(district)
                                                .frame(width: 35)
                                            Text(item.province ?? "")
                                                .font(.system(size: 16))
                                                .foregroundColor(theme.textColor.opacity(0.8))
                                                .frame(width: 20)
                                                .offset(y: -10)
                                        }
                                    } else {
                                        HStack(alignment: .firstTextBaseline) {
                                            Text(item.district ?? "")
                                                .frame(width: 35)
                                            Text(item.city ?? "")
                                                .font(.system(size: 16))
                                                .foregroundColor(theme.textColor.opacity(0.8))
                                                .frame(width: 20)
                                                .offset(y: -10)
                                        }
                                    }
                                })
                                
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .font(.custom("SourceHanSerif-SemiBold", size: 28))
                            .foregroundColor(placeStore.activePlace == item ? theme.textColor : theme.inactiveColor)
                            .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
                            .animation(.easeInOut)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .frame(height: 320)
            .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
            .cornerRadius(30)
            .padding(.horizontal, 10)
            .padding(.bottom, 30)
            .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
        }
    }
    
    func chooseCity (_ item: Place) {
        if showRemoveBtn == false {
            UserDefaults.standard.set(item.districtCode, forKey: "activedDistrictCode")
            placeStore.activePlace = item
            weatherStore.getWeather(districtId: String(item.districtCode))
            showCityList.toggle()
        } else if showRemoveBtn && !item.isAppLocation {
            self.removeCity(item)
        }
    }
    
    func removeCity (_ item: Place) {
        if placeStore.activePlace == item {
            placeStore.activePlace = placeList[0]
            UserDefaults.standard.set(placeList[0].districtCode, forKey: "activedDistrictCode")
        }
        placeStore.removePlace(item)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(
            showCityList: .constant(true)
        )
        .environmentObject(Theme())
        .environmentObject(PlaceViewModel())
    }
}

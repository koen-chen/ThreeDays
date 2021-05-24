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
        sortDescriptors: []
    ) var placeList: FetchedResults<Place>
    
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var placeStore: PlaceViewModel
    
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
                       //CitySearchView()
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
                    HStack(alignment: .firstTextBaseline, spacing: 38) {
                        ForEach(placeList) { item in
                            VStack {
                                if showRemoveBtn {
                                    Button(action: {
                                        if placeStore.activeCity != item.city {
                                            self.removeCity(item)
                                        }
                                    }, label: {
                                        Image(systemName: placeStore.activeCity == item.city ? "circle.lefthalf.fill" : "xmark.circle")
                                    })
                                    .font(.system(size: 20))
                                    .padding(.bottom, 2)
                                }

                                Button(action: {
                                    chooseCity(item)
                                }, label: {
                                    Text(item.city ?? "")
                                        .frame(width: 35)
                                })
                                
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .font(.custom("SourceHanSerif-SemiBold", size: 28))
                            .foregroundColor(placeStore.activeCity == item.city ? theme.textColor : theme.inactiveColor)
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
    
    func chooseCity (_ city: Place) {
//        if showRemoveBtn == false {
//            activeCity = city.name
//            weatherStore.getWeather(districtId: String(city.adcode))
//            showCityList.toggle()
//        } else if showRemoveBtn && activeCity != city.name {
//            self.removeCity(city)
//        }
    }
    
    func removeCity (_ city: Place) {
//        cityList = cityList.filter({ item in
//            return item.city != chosen.city
//        })
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

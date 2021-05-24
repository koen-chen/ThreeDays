//
//  CitySearchView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import SwiftUI

struct CitySearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var placeStore: PlaceViewModel
    
    @ObservedObject var citySearchViewModel = CitySearchViewModel()
    
    @State var isSearching = false
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                })
               
                TextField("请输入城市或者市县区名称", text: $citySearchViewModel.searchText)
                    .font(.custom("SourceHanSerif-SemiBold", size: 16))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.vertical, 15)
                    .onTapGesture {
                        self.isSearching = true
                    }
                
                if isSearching {
                    Button(action: {
                        self.isSearching = false
                        citySearchViewModel.searchText = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                            .animation(.easeInOut)
                    })
                }
            }
            .background(Color(#colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 0.9921568627, alpha: 1)).opacity(0.9))
            .clipped()
            .cornerRadius(15)
            
            if citySearchViewModel.searchCitys.count > 0 {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(citySearchViewModel.searchCitys, id: \.self) { item in
                            ItemView(item: item)
                                .environmentObject(Theme())
                                .onTapGesture {
                                    placeStore.addPlace(item)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            
                            Divider().background(theme.backgroundColor).padding(.vertical, 30)
                        }
                    }
                    .padding(.vertical, 50)
                    .font(.custom("SourceHanSerif-SemiBold", size: 28))
                    .foregroundColor(theme.textColor)
                    .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
                    .animation(.easeInOut)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 60)
        .padding(.horizontal, 20)
        .foregroundColor(theme.textColor)
        .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
        .ignoresSafeArea()
    }
}

struct CitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView()
            .environmentObject(Theme())
            .environmentObject(PlaceViewModel())
    }
}

struct ItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var placeStore: PlaceViewModel
    
    var item: PlaceModel
    
    var body: some View {
        HStack {
            if item.district == item.city.dropLast() {
                VStack(alignment: .leading) {
                    Text(item.city)
                    Text(item.province)
                        .font(.system(size: 16))
                        .padding(.top, 5)
                        .foregroundColor(theme.textColor.opacity(0.8))
                }
            } else {
                VStack(alignment: .leading) {
                    Text(item.district)
                    HStack {
                        Text(item.province)
                        Text(item.city)
                    }
                    .font(.system(size: 16))
                    .padding(.top, 5)
                    .foregroundColor(theme.textColor.opacity(0.8))
                }
            }
            
            Spacer()
            
            Button(action: {
                placeStore.addPlace(item)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 38))
            })
        }
       
        
    }
}

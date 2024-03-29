//
//  PlaceSearchView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import SwiftUI

struct PlaceSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: PlaceListViewModel
    
    @ObservedObject var citySearchViewModel = PlaceSearchViewModel()
    
    @State var isSearching = false
    
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.down.circle")
                        .font(.system(size: 28))
                })
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                    })
                   
                    TextField("请输入中国城市或区县名称", text: $citySearchViewModel.searchText)
                        .font(.custom(theme.font, size: 16))
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
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding(.trailing, 16)
                                .animation(.easeInOut)
                        })
                    }
                }
                .background(Color(#colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 0.9921568627, alpha: 1)).opacity(0.9))
                .clipped()
                .cornerRadius(15)
            }
            
            if citySearchViewModel.searchCitys.count > 0 {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        ForEach(citySearchViewModel.searchCitys, id: \.self) { item in
                            ItemView(item: item)
                                .contentShape(Rectangle())
                                .environmentObject(Theme())
                                .onTapGesture {
                                    viewModel.addPlace(item)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            
                            Divider().background(theme.backgroundColor).padding(.vertical, 30)
                        }
                    }
                    .padding(.vertical, 50)
                    .font(.custom(theme.font, size: 28))
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


struct ItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: PlaceListViewModel
    
    var item: ChinaPlace.Place
    
    var body: some View {
        HStack {
            if item.regionCN == item.cityCN {
                VStack(alignment: .leading) {
                    Text(item.cityCN)
                    Text(item.provinceCN)
                        .font(.system(size: 16))
                        .padding(.top, 5)
                        .foregroundColor(theme.textColor.opacity(0.8))
                }
            } else {
                VStack(alignment: .leading) {
                    Text(item.regionCN)
                    HStack {
                        Text(item.provinceCN)
                        Text(item.cityCN)
                    }
                    .font(.system(size: 16))
                    .padding(.top, 5)
                    .foregroundColor(theme.textColor.opacity(0.8))
                }
            }
            
            Spacer()
            
            Image(systemName: "plus")
                .font(.system(size: 38))
        }
    }
}

struct PlaceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceSearchView()
            .environmentObject(Theme())
            .environmentObject(PlaceListViewModel())
    }
}

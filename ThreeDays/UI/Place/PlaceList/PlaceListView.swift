//
//  PlaceListView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/17.
//

import SwiftUI
import CoreData

struct PlaceListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: PlaceListViewModel
    
    @FetchRequest(
        entity: Place.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Place.isAppLocation, ascending: false),
            NSSortDescriptor(keyPath: \Place.createdAt, ascending: false)
        ]
    )  var dbPlaceList: FetchedResults<Place>
    
    @Binding var showCityList: Bool
    @State var showRemoveBtn: Bool = false
    @State var showCitySearchView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Rectangle()
                    .frame(width: 40, height: 6)
                    .foregroundColor(theme.textColor)
                    .cornerRadius(3)
                    .opacity(0.5)
                    .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)

                HStack {
                    Button(action: {
                        self.showCitySearchView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                    .fullScreenCover(isPresented: $showCitySearchView) {
                       PlaceSearchView()
                        .environmentObject(theme)
                        .environmentObject(viewModel)
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
                .padding(.top, 10)
                
              
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .firstTextBaseline, spacing: 40) {
                        ForEach(dbPlaceList) { item in
                            VStack(spacing: 0) {
                                if showRemoveBtn {
                                    Image(systemName: item.isAppLocation ? "location.circle" : "xmark.circle")
                                        .font(.custom(theme.font, size: 22))
                                        .padding(.all, 10)
                                }

                                Group {
                                    if let regionCN = item.regionCN,
                                       let cityCN = item.cityCN,
                                       regionCN == cityCN {
                                        HStack(alignment: .firstTextBaseline) {
                                            Text(regionCN)
                                                .frame(width: 35)
                                            Text(item.provinceCN ?? "")
                                                .font(.system(size: 16))
                                                .foregroundColor(theme.textColor.opacity(0.8))
                                                .frame(width: 20)
                                                .offset(y: -10)
                                        }
                                    } else {
                                        HStack(alignment: .firstTextBaseline) {
                                            Text(item.regionCN ?? "")
                                                .frame(width: 35)
                                            Text(item.cityCN ?? "")
                                                .font(.system(size: 16))
                                                .foregroundColor(theme.textColor.opacity(0.8))
                                                .frame(width: 20)
                                                .offset(y: -10)
                                        }
                                    }
                                }
                                .font(.custom(theme.font, size: 28))
                                .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .contentShape(Rectangle())
                            .foregroundColor(theme.textColor)
                            .animation(.easeInOut)
                            .onTapGesture(perform: {
                                chooseCity(item)
                            })
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
            .cornerRadius(30)
            .padding(.horizontal, 10)
            .shadow(color: theme.backgroundColor.opacity(0.6), radius: 10, x: 0, y: 0)
        }
    }
    
    func chooseCity (_ item: Place) {
        if showRemoveBtn == false {
            UserDefaults.standard.set(item.placeID, forKey: "activedPlaceID")
            viewModel.changeActivePlace(item)
            showCityList.toggle()
        } else if showRemoveBtn && !item.isAppLocation {
            self.removeCity(item)
        }
    }
    
    func removeCity (_ item: Place) {
        if item.isAppLocation {
            return
        }
        
        if viewModel.activePlace == item {
            viewModel.changeActivePlace(dbPlaceList[0])
            UserDefaults.standard.set(dbPlaceList[0].placeID, forKey: "activedPlaceID")
        }
        
        DispatchQueue.main.async {
            viewModel.removePlace(item)
        }
    }
}

//
//  CitySearchView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import SwiftUI

struct CitySearchView: View {
    @ObservedObject var cityViewModel = CitySearchViewModel()
    
    @State var isSearching = false
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                })
               
                TextField("输入城市名称", text: $cityViewModel.searchText)
                    .font(.custom("SourceHanSerif-SemiBold", size: 16))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.vertical, 15)
                    .onTapGesture {
                        self.isSearching = true
                    }
                
                if isSearching {
                    Button(action: {
                        self.isSearching = false
                        cityViewModel.searchText = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                            .animation(.easeInOut)
                    })
                }
            }
            .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)).opacity(0.5))
            .clipped()
            .cornerRadius(15)
            
            Spacer()
        }
        .padding()
    }
}

struct CitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView()
    }
}

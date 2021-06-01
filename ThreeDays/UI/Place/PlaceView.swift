//
//  PlaceView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/1.
//

import SwiftUI

struct PlaceView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var viewModel: PlaceListViewModel
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
                        
                        if let region = viewModel.activePlace?.regionCN,
                           let city = viewModel.activePlace?.cityCN,
                           (region == city.dropLast() || region == city){
                            VStack(alignment: .leading, spacing: 5) {
                                Text(region)
                                Text(viewModel.activePlace?.provinceCN ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(theme.textColor.opacity(0.8))
                            }.font(.custom(theme.font, size: 24))
                        } else {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(viewModel.activePlace?.regionCN ?? "")
                                Text(viewModel.activePlace?.cityCN ?? "")
                                    .font(.system(size: 14))
                                    .foregroundColor(theme.textColor.opacity(0.8))
                            }.font(.custom(theme.font, size: 22))
                        }
                    }
                })
                
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, theme.screen.height < 800 ? 10 : 30)
    }
}

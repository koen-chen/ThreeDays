//
//  DayView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/1.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var theme: Theme
    
    var dailyText: String
    var dateText: (Int, Int, Int)
    @Binding var showDayList: Bool
    
    var lunarInfo: String? {
        guard dateText != (0,0,0) else { return nil }
        return LunarService.getLunarSpecialDate(iYear: dateText.0, iMonth: dateText.1, iDay: dateText.2)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                
                HStack(alignment: .top) {
                    VStack(spacing: 10) {
                        Text(dailyText)

                        if let lunarInfo = lunarInfo {
                            Text(lunarInfo)
                                .padding(.vertical, 6)
                                .frame(width: 24)
                                .cornerRadius(6)
                                .font(.custom(theme.font, size: 14))
                                .background(theme.backgroundColor.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6).stroke(theme.backgroundColor.opacity(0.6), lineWidth: 1)
                                )
                        }
                    }
                    
                    VStack {
                        Button(action: {
                            self.showDayList.toggle()
                        }, label: {
                            Image(systemName: "circle.righthalf.fill")
                                .rotationEffect(Angle.degrees(self.showDayList ? 180 : 0))
                                .padding(.bottom, 2)
                        })
                        
                        
                        Text("\(dateText.1)")
                        Text("月")
                        Text("\(dateText.2)")
                        Text("日")
                    }
                    .font(.custom(theme.font, size: 14))
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


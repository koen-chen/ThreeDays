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
    var dateText: (Int, Int)
    @Binding var showDayList: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Spacer()
                
                HStack(alignment: .lastTextBaseline) {
                    Text(dailyText)
                    
                    VStack {
                        Button(action: {
                            self.showDayList.toggle()
                        }, label: {
                            Image(systemName: "circle.righthalf.fill")
                                .rotationEffect(Angle.degrees(self.showDayList ? 180 : 0))
                                .padding(.bottom, 2)
                        })
                        
                        
                        Text("\(dateText.0)")
                        Text("月")
                        Text("\(dateText.1)")
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


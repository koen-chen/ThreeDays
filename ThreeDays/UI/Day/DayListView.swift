//
//  DailyListView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/15.
//

import SwiftUI

struct DayListView: View {
    @EnvironmentObject var theme: Theme
    @Binding var showDayList: Bool
    @Binding var activeDay: Int
    
    let dayList = ["今\n日", "明\n日", "后\n日"]
    
    var body: some View {
         VStack {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30) {
                ForEach(dayList.indices) { index in
                    Button(action: {
                        chooseDay(active: index)
                    }) {
                        Text(dayList[index])
                    }
                    .foregroundColor(activeDay == index ? theme.textColor : theme.inactiveColor)
                    
                    if index == 0 || index == 1 {
                        Divider().background(theme.backgroundColor).padding(.vertical, 30)
                    }
                }
            }
            .font(.custom(theme.font, size: 38))
            .shadow(color: theme.textColor.opacity(0.3), radius: 3, x: 3, y: 3)
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
            .cornerRadius(30)
            .padding(.vertical, 30)
            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
    }
    
    func chooseDay (active: Int) {
        activeDay = active
        showDayList.toggle()
    }
}

struct DailyMenu_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(showDayList: .constant(false), activeDay: .constant(1))
            .environmentObject(Theme())
    }
}

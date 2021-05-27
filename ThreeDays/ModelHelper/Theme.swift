//
//  Theme.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/25.
//

import SwiftUI

class Theme: ObservableObject {
    var isDaytime: Bool {
        let d = Calendar.current.dateComponents(in: TimeZone(abbreviation: "GMT+8")!, from: Date())
        return  6...18 ~= d.hour! ? true : false
        //return  6...18 ~= d.hour! ? false : true
    }
    
    var backgroundColor: Color {
        return  isDaytime ? Color(#colorLiteral(red: 0.4470588235, green: 0.6392156863, blue: 0.8470588235, alpha: 1)) : Color(#colorLiteral(red: 0.7333333333, green: 0.6823529412, blue: 0.7960784314, alpha: 1))
    }
    
    var textColor: Color {
        return isDaytime ? Color(#colorLiteral(red: 0.2862745098, green: 0.5803921569, blue: 0.768627451, alpha: 1)) : Color(#colorLiteral(red: 0.4901960784, green: 0.3215686275, blue: 0.5176470588, alpha: 1))
    }
    
    var inactiveColor: Color {
        return isDaytime ? Color(#colorLiteral(red: 0.2862745098, green: 0.5803921569, blue: 0.768627451, alpha: 0.6026524222)) : Color(#colorLiteral(red: 0.4901960784, green: 0.3215686275, blue: 0.5176470588, alpha: 0.6036306217))
    }
    
    var iconText: String {
        return isDaytime ? "day" : "night"
    }
}

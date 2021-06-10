//
//  Extension.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/10.
//

import Foundation

extension String {
    func weekdayFormater() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let weekDay = calendar.component(.weekday, from: formatDate)
        
        switch weekDay {
            case 1:
                return "星期日"
            case 2:
                return "星期一"
            case 3:
                return "星期二"
            case 4:
                return "星期三"
            case 5:
                return "星期四"
            case 6:
                return "星期五"
            case 7:
                return "星期六"
            default:
                return ""
        }
    }
}

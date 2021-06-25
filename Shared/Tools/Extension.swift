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
                return "周日"
            case 2:
                return "周一"
            case 3:
                return "周二"
            case 4:
                return "周三"
            case 5:
                return "周四"
            case 6:
                return "周五"
            case 7:
                return "周六"
            default:
                return ""
        }
    }
}

//
//  Description.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/1.
//

import Foundation

struct Description {
    
    
    static func dayDesc(_ activeDay: Int = 0) -> String {
        switch activeDay {
            case 0:
                return "今\n日"
            case 1:
                return "明\n日"
            case 2:
                return "后\n日"
            default:
                return ""
        }
    }
    
    static func weatherDesc(_ text: String) -> String {
        switch text {
            case "雷阵雨伴有冰雹":
                return "雷阵雨"
            case "大暴雨", "大到暴雨", "暴雨到大暴雨", "大暴雨到特大暴雨", "特大暴雨":
                return "暴雨"
            case "小到中雨":
                return "中雨"
            case "中到大雨":
                return "大雨"
            case "小到中雪":
                return "中雪"
            case "中到大雪":
                return "大雪"
            case "大到暴雪":
                return "暴雪"
            case "强沙尘暴":
                return "沙尘暴"
            case "特强浓雾":
                return "强浓雾"
            case "弱高吹雪":
                return "高吹雪"
            default:
                return text
        }
    }
}

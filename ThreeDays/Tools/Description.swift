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
            case "晴间多云":
                return "多云"
            case "强雷阵雨", "雷阵雨伴有冰雹":
                return "雷阵雨"
            case "毛毛雨/细雨":
                return "小雨"
            case "极端降雨", "大暴雨", "大到暴雨", "暴雨到大暴雨", "大暴雨到特大暴雨", "特大暴雨":
                return "暴雨"
            case "小到中雨":
                return "中雨"
            case "中到大雨":
                return "大雨"
            case "雨雪天气", "阵雨夹雪":
                return "雨夹雪"
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
    
    static func weatherLottieIcon(_ text: String?) -> String {
        if let code = text {
            switch code {
                case "100", "150":
                    return "clear-sky"
                case "101", "102", "103", "153":
                    return "scattered-clouds"
                case "104", "154":
                    return "few-clouds"
                case "305", "306", "307", "308", "309", "310", "311", "312",
                     "313", "314", "315", "316", "317", "318", "399":
                    return "rain"
                case "300", "301", "350", "351":
                    return "shower-rains"
                case "302", "303", "304":
                    return "thunderstorm"
                case "400", "401", "402", "403", "404", "405", "406", "407",
                     "408", "409", "410", "499", "456", "457":
                    return "snow"
                case "500", "501", "502", "509", "510", "511", "512", "513", "514", "515":
                    return "mist"
                case "503", "504", "507", "508":
                    return "wind"
                default:
                    return ""
            }
        } else {
            return ""
        }
    }
    
    static func weatherSystemIcon(_ text: String?) -> String {
        if let code = text {
            switch code {
                case "100", "150":
                    return "sun.max"
                case "101", "102", "103", "153":
                    return "smoke"
                case "104", "154":
                    return "cloud"
                case "305", "306", "307", "308", "309", "310", "311", "312",
                     "313", "314", "315", "316", "317", "318", "399":
                    return "cloud.rain"
                case "300", "301", "350", "351":
                    return "cloud.sun.rain"
                case "302", "303", "304":
                    return "cloud.bolt"
                case "400", "401", "402", "403", "404", "405", "406", "407",
                     "408", "409", "410", "499", "456", "457":
                    return "cloud.snow"
                case "500", "501", "502", "509", "510", "511", "512", "513", "514", "515":
                    return "cloud.fog"
                case "503", "504", "507", "508":
                    return "wind"
                default:
                    return ""
            }
        } else {
            return ""
        }
    }
}

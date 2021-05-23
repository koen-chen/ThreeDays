//
//  WeatherModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/7.
//

import Foundation

struct WeatherModel: Codable {
    struct Now: Codable {
        var text: String = ""
        var temp: Int = 0
        var wind_class: String = ""
        var wind_dir: String = ""
    }
    
    struct Forecasts: Codable {
        var text_day: String = ""
        var text_night: String = ""
        var high: Int = 0
        var low: Int = 0
        var wc_day: String = ""
        var wd_day: String = ""
        var wc_night: String = ""
        var wd_night: String = ""
        var date: String = ""
    }
    
    struct Result: Codable {
        var now: Now?
        var forecasts: [Forecasts]?
    }
    
    var result = Result()
}

//
//  WeatherNowModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/7.
//

import Foundation

struct WeatherNowModel: Codable {
    struct Now: Codable {
        var text: String
        var icon: String
        var temp: String
        var feelsLike: String
        var wind360: String
        var windDir: String
        var windSpeed: String
        var humidity: String
        var vis: String
    }
    
    var now: Now
    var code: String
    var updateTime: String
}

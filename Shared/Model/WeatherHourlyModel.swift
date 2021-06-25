//
//  WeatherHourModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/2.
//

import Foundation

struct WeatherHourlyModel: Codable {
    struct Hourly: Codable {
        var fxTime: String
        var temp: String
        var icon: String
        var text: String
        var wind360: String
        var windDir: String
        var windScale: String
        var windSpeed: String
        var humidity: String
        var pop: String
        var precip: String
        var pressure: String
        var cloud: String
        var dew: String
    }
    
    var hourly: [Hourly]
    var code: String
    var updateTime: String
}

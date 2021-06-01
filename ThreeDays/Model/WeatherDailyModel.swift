//
//  DailyWeatherModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/1.
//

import Foundation

struct WeatherDailyModel: Codable {
    struct Daily: Codable {
        var fxDate: String
        var tempMax: String
        var tempMin: String
        var iconDay: String
        var textDay: String
        var iconNight: String
        var textNight: String
        var wind360Day: String
        var windDirDay: String
        var windSpeedDay: String
        var wind360Night: String
        var windDirNight: String
        var windSpeedNight: String
        var humidity: String
        var vis: String
        var uvIndex: String
        var moonPhase: String
    }
    
    var daily: [Daily]
    var code: String
    var updateTime: String
}

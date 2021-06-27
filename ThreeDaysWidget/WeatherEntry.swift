//
//  WeatherEntry.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit

struct WeatherEntry: TimelineEntry {
    let date: Date
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceId: String?
    let activePlaceName: String?
}

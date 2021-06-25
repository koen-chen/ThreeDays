//
//  WidgetTimelineProvider.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit

class WidgetTimelineProvider: IntentTimelineProvider {
    
    typealias Entry = WeatherEntry
    
    private let userDefaultsService = UserDefaultsService.shared
    private let nowWeather: WeatherNowModel?
    private let dailyWeather: WeatherDailyModel?
    
    init() {
        nowWeather = userDefaultsService.fetchWeatherNow()
        dailyWeather = userDefaultsService.fetchWeatherDaily()
    }
    
    func placeholder(in context: Context) -> Entry {
       placeholderEntry()
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = Entry(date: Date(), nowWeather: nowWeather, dailyWeather: dailyWeather)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        
        var entries: [Entry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = Entry(date: entryDate)
//            entries.append(entry)
//        }
        
        entries.append(Entry(date: Date(), nowWeather: nowWeather, dailyWeather: dailyWeather))
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func placeholderEntry() -> Entry {
        Entry(date: Date(), nowWeather: nowWeather, dailyWeather: dailyWeather)
    }
}

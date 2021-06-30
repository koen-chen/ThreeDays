//
//  WidgetTimelineProvider.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit
import Combine

class WidgetTimelineProvider: TimelineProvider {
    typealias Entry = WeatherEntry
    
    private let API = APIService()
    private let userDefaultsService = UserDefaultsService.shared
    private let nowWeather: WeatherNowModel?
    private let dailyWeather: WeatherDailyModel?
    private let activePlaceId: String?
    private let activePlaceName: String?
    private var cancellables = Set<AnyCancellable>()
    
    var timelineWeatherNow: WeatherNowModel?
    var timelineWeatherDaily: WeatherDailyModel?
    
    var refreshDate: Date?
    
    init() {
        nowWeather = userDefaultsService.fetchWeatherNow()
        dailyWeather = userDefaultsService.fetchWeatherDaily()
        activePlaceId = userDefaultsService.fetchActivePlaceId()
        activePlaceName = userDefaultsService.fetchActivePlaceName()
    }
    
    func placeholder(in context: Context) -> Entry {
       placeholderEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = Entry(
            date: Date(),
            nowWeather: nowWeather,
            dailyWeather: dailyWeather,
            activePlaceId: activePlaceId,
            activePlaceName: activePlaceName
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let callback = completion
        
        getWeatherNow(location: self.activePlaceId!) { weatherNow in
            self.getWeatherDaily(location: self.activePlaceId!) { weatherDaily in
                let currentDate = Date()
                let midnightDate = Calendar.current.startOfDay(for: currentDate)
                
                let diffComponents = Calendar.current.dateComponents([.hour], from: currentDate, to: midnightDate)
                let hours = abs(diffComponents.hour ?? 0)
                
                let restHours = 24 - hours
                
                if (1...3).contains(restHours) {
                    self.refreshDate = Calendar.current.date(byAdding: .hour, value: restHours, to: currentDate)
                } else {
                    self.refreshDate = Calendar.current.date(byAdding: .hour, value: 4, to: currentDate)
                }

                let entry = Entry(
                    date: currentDate,
                    nowWeather: weatherNow,
                    dailyWeather: weatherDaily,
                    activePlaceId: self.activePlaceId,
                    activePlaceName: self.activePlaceName
                )
                
                let timeline = Timeline(entries: [entry], policy: .after(self.refreshDate!))
                
                callback(timeline)
            }
        }
    }
    
    private func getWeatherNow (location: String, completion: @escaping (WeatherNowModel) -> Void) {
        API.getWeatherNow(location)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                completion(value)
            }
            .store(in: &cancellables)
    }
    
    private func getWeatherDaily (location: String, daily: String = "3d", completion: @escaping (WeatherDailyModel) -> Void) {
        API.getWeatherDaily(location, daily: daily)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                completion(value)
            }
            .store(in: &cancellables)
    }
    
    private func placeholderEntry() -> Entry {
        Entry(
            date: Date(),
            nowWeather: nowWeather,
            dailyWeather: dailyWeather,
            activePlaceId: activePlaceId,
            activePlaceName: activePlaceName
        )
    }
}

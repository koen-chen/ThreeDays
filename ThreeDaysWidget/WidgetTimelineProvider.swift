//
//  WidgetTimelineProvider.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit
import Combine

class WidgetTimelineProvider: IntentTimelineProvider {
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
    
    init() {
        nowWeather = userDefaultsService.fetchWeatherNow()
        dailyWeather = userDefaultsService.fetchWeatherDaily()
        activePlaceId = userDefaultsService.fetchActivePlaceId()
        activePlaceName = userDefaultsService.fetchActivePlaceName()
    }
    
    func placeholder(in context: Context) -> Entry {
       placeholderEntry()
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = Entry(
            date: Date(),
            nowWeather: nowWeather,
            dailyWeather: dailyWeather,
            activePlaceId: activePlaceId,
            activePlaceName: activePlaceName
        )
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWeatherNow(location: self.activePlaceId!) { entry in
            let refreshDate = Calendar.current.date(byAdding: .hour, value: 6, to: Date())
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate!))
            completion(timeline)
        }
    }
    
    func getWeatherNow (location: String, completion: @escaping (Entry) -> Void) {
        API.getWeatherNow(location)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                completion(Entry(
                    date: Date(),
                    nowWeather: value,
                    dailyWeather: self.dailyWeather,
                    activePlaceId: self.activePlaceId,
                    activePlaceName: self.activePlaceName
                ))
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

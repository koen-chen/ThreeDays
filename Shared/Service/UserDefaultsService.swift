//
//  UserDefaultsService.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/24.
//

import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    let userDefaults: UserDefaults
    
    private let activePlaceIdKey = "active_place_id_key"
    private let activePlaceNameKey = "active_place_name_key"
    private let weatherNowKey = "now_weather_key"
    private let weatherDailyKey = "daily_weather_key"
    private let weatherHourlyKey = "hourly_weather_key"
    
    init () {
        if let userDefaults = UserDefaults(suiteName: "group.koen.chen.ThreeDays") {
            self.userDefaults = userDefaults
        } else {
            self.userDefaults = UserDefaults.standard
        }
    }
    
    func save(activePlaceId: String) {
        userDefaults.setValue(activePlaceId, forKey: activePlaceIdKey)
    }
    
    func save(activePlaceName: String) {
        userDefaults.setValue(activePlaceName, forKey: activePlaceNameKey)
    }
    
    func save(weatherNow: WeatherNowModel?) {
        guard let weatherNow = weatherNow, let encodeedObjet = try? JSONEncoder().encode(weatherNow) else { return }
        
        userDefaults.setValue(encodeedObjet, forKey: weatherNowKey)
    }
    
    func save(weatherDaily: WeatherDailyModel?) {
        guard let weatherDaily = weatherDaily, let encodeedObjet = try? JSONEncoder().encode(weatherDaily) else { return }
        
        userDefaults.setValue(encodeedObjet, forKey: weatherDailyKey)
    }
    
    func save(weatherHourly: WeatherHourlyModel?) {
        guard let weatherHourly = weatherHourly, let encodeedObjet = try? JSONEncoder().encode(weatherHourly) else { return }
        
        userDefaults.setValue(encodeedObjet, forKey: weatherHourlyKey)
    }
    
    func fetchActivePlaceId() -> String? {
        guard let result = userDefaults.string(forKey: activePlaceIdKey) else { return nil }
        
        return result
    }
    
    func fetchActivePlaceName() -> String? {
        guard let result = userDefaults.string(forKey: activePlaceNameKey) else { return nil }
        
        return result
    }
    
    func fetchWeatherNow() -> WeatherNowModel? {
        guard let data = userDefaults.object(forKey: weatherNowKey) as? Data,
              let result = try? JSONDecoder().decode(WeatherNowModel.self, from: data)
        else { return nil }
        
        return result
    }
    
    func fetchWeatherDaily() -> WeatherDailyModel? {
        guard let data = userDefaults.object(forKey: weatherDailyKey) as? Data,
              let result = try? JSONDecoder().decode(WeatherDailyModel.self, from: data)
        else { return nil }
        
        return result
    }
    
    func fetchWeatherHourly() -> WeatherHourlyModel? {
        guard let data = userDefaults.object(forKey: weatherHourlyKey) as? Data,
              let result = try? JSONDecoder().decode(WeatherHourlyModel.self, from: data)
        else { return nil }
        
        return result
    }
}

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
    
    private let activePlaceKey = "active_place_key"
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
    
    func save(activePlace: String) {
        userDefaults.setValue(activePlace, forKey: activePlaceKey)
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
    
    func fetchActivePlace() -> String? {
        guard let result = userDefaults.string(forKey: activePlaceKey) else { return nil }
        
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

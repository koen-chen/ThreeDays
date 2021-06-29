//
//  WeatherViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/9.
//

import SwiftUI
import Combine
import WidgetKit

class WeatherViewModel: ObservableObject {
    @Published var weatherNow: WeatherNowModel?
    @Published var weatherDaily: WeatherDailyModel?
    @Published var weatherHourly: WeatherHourlyModel? 
    
    private let API = APIService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        PlaceListViewModel.placePublisher.sink { completion in
        } receiveValue: { id in
            if let id = id {
                self.getWeatherNow(location: id)
                self.getWeatherDaily(location: id, daily: "10d")
                self.getWeatherHourly(location: id)
                
            
                WidgetCenter.shared.reloadAllTimelines()
            }
        }.store(in: &cancellables)
    }
    
    func getWeatherNow (location: String) {
        API.getWeatherNow(location)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                self.weatherNow = value
    
                UserDefaultsService.shared.save(weatherNow: self.weatherNow)
            }
            .store(in: &cancellables)
    }
    
    func getWeatherDaily (location: String, daily: String = "3d") {
        API.getWeatherDaily(location, daily: daily)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                self.weatherDaily = value
                
                UserDefaultsService.shared.save(weatherDaily: self.weatherDaily)
            }
            .store(in: &cancellables)
    }
    
    func getWeatherHourly (location: String) {
        API.getWeatherHourly(location)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                self.weatherHourly = value
                
                UserDefaultsService.shared.save(weatherHourly: self.weatherHourly)
            }
            .store(in: &cancellables)
    }
}

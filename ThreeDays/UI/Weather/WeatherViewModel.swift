//
//  WeatherViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/9.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherNow: WeatherNowModel?
    @Published var weatherDaily: WeatherDailyModel?
    @Published var weatherHourly: WeatherHourlyModel?
    
    private let API = APIService()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        PlaceListViewModel.placePublisher.sink { completion in
        } receiveValue: { id in
            if let id = id {
                self.getWeatherNow(location: id)
                self.getWeatherDaily(location: id, daily: "10d")
                self.getWeatherHourly(location: id)
            }
        }.store(in: &subscriptions)
    }
    
    func getWeatherNow (location: String) {
        API.getWeatherNow(location)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                self.weatherNow = value
            }
            .store(in: &subscriptions)
    }
    
    func getWeatherDaily (location: String, daily: String = "3d") {
        API.getWeatherDaily(location, daily: daily)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                self.weatherDaily = value
            }
            .store(in: &subscriptions)
    }
    
    func getWeatherHourly (location: String) {
        API.getWeatherHourly(location)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { value in
                self.weatherHourly = value
            }
            .store(in: &subscriptions)
    }
}

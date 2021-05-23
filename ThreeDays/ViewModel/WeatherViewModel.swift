//
//  WeatherViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/9.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather = WeatherModel()
    @Published var placeLocality = "未知"
    @Published var placeSubLocality = ""
    
    @ObservedObject var locationProvider: LocationProvider
    
    private let weatherProvider = WeatherProvider()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        locationProvider = LocationProvider()
        locationProvider.startLocation()
        locationProvider.locationPublisher.sink { completion in
            if let adcode = CitySource.getCityCode(self.placeLocality) {
                self.getWeather(districtId: String(adcode))
            }
        } receiveValue: { (placeLocality, placeSubLocality) in
            self.placeLocality = placeLocality
            self.placeSubLocality = placeSubLocality
        }.store(in: &subscriptions)
    }
    
    func getWeather (districtId: String) {
        weatherProvider
            .getWeather(districtId: districtId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { weather in
                self.weather = weather
            }
            .store(in: &subscriptions)
    }
}

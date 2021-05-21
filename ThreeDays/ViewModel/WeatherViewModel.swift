//
//  WeatherStore.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/9.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather = WeatherModel()
    @Published var placeName = "未知"
    @Published var placeCountry = "未知"
    @Published var placeLocality = "未知"
    @Published var adcode = ""
    @ObservedObject var locationProvider: LocationProvider
    
    private let weatherProvider = WeatherProvider()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        locationProvider = LocationProvider()
        locationProvider.startLocation()
        locationProvider.locationPublisher.sink { completion in
            self.getDistrictId()
        } receiveValue: { (placeName, placeLocality, placeCountry) in
            self.placeName = placeName
            self.placeCountry = placeCountry
            self.placeLocality = placeLocality
        }.store(in: &subscriptions)
    }
    
    func getDistrictId () {
        weatherProvider
            .getDistrict(keyword: self.placeLocality)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { location in
                self.getWeather(districtId: location.results[0].adcode)
            }
            .store(in: &subscriptions)
    }
    
    func getWeather (districtId: String) {
        weatherProvider
            .getWeather(districtId: districtId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { weather in
                print(weather)
                self.weather = weather
            }
            .store(in: &subscriptions)
    }
    
    
}

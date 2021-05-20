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
    @ObservedObject var locationStore: LocationService
    
    private var subscription: AnyCancellable?
    private let service = WeatherService()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        locationStore = LocationService()
        locationStore.startLocation()
        locationStore.locationPublisher.sink { completion in
            self.getDistrictId()
        } receiveValue: { (placeName, placeLocality, placeCountry) in
            self.placeName = placeName
            self.placeCountry = placeCountry
            self.placeLocality = placeLocality
        }.store(in: &subscriptions)
    }
    
    func getDistrictId () {
        service
            .getDistrict(keyword: self.placeLocality)
            .receive(on: DispatchQueue.main)
            .sink { completion in
               print("Finished getDistrictId API")
            } receiveValue: { location in
                self.getWeather(districtId: location.results[0].adcode)
            }
            .store(in: &subscriptions)
    }
    
    func getWeather (districtId: String) {
        service
            .getWeather(districtId: districtId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Finished getWeather API")
            } receiveValue: { weather in
                print(weather)
                self.weather = weather
            }
            .store(in: &subscriptions)
    }
    
    
}

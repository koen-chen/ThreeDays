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

    private let apiProvider = APIProvider()
    private var subscriptions = Set<AnyCancellable>()
    
    func getWeather (districtId: String) {
        apiProvider
            .getWeather(districtId: districtId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { weather in
                self.weather = weather
            }
            .store(in: &subscriptions)
    }
}

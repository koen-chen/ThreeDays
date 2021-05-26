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
    
    var districtCode: Int64?
    
    init() {
        PlaceViewModel.placePublisher.sink { completion in
            if let code = self.districtCode {
                self.getWeather(districtId: String(code))
            }
        } receiveValue: { code in
            self.districtCode = code
        }.store(in: &subscriptions)
    }
    
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

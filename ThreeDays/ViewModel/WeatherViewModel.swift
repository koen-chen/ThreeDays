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
//    @Published var placeProvince = ""
//    @Published var placeCity = "未知"
//    @Published var placeDistrict = ""
    
//    @ObservedObject var locationProvider: LocationProvider
    
    private let apiProvider = APIProvider()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
//        locationProvider = LocationProvider()
//        locationProvider.startLocation()
//        locationProvider.locationPublisher.sink { completion in
//            if let districtcode = PlaceCSV.shared.getCityCode(self.placeCity) {
//                if !PersistenceProvider.shared.checkEntityHasData(NSPredicate(format: "districtcode == %d", districtcode)) {
//                    let city = City(context: PersistenceProvider.shared.managedObjectContext)
//                    city.adcode = adcode
//                    city.name = self.placeLocality
//                    city.createdAt = Date()
//                    city.region = self.placeSubLocality
//                    PersistenceProvider.shared.saveContext()
//                }
//
//                self.getWeather(districtId: String(districtcode))
//            }
//        } receiveValue: { (placeProvince, placeCity, placeDistrict) in
//            self.placeProvince = placeProvince
//            self.placeCity = placeCity
//            self.placeDistrict = placeDistrict
//        }.store(in: &subscriptions)
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

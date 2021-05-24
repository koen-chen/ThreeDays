//
//  PlaceViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/24.
//

import SwiftUI
import Combine

class PlaceViewModel: ObservableObject {
    @Published var placeProvince = ""
    @Published var placeCity = ""
    @Published var placeDistrict = ""
    @Published var districtCode: Int64? = nil
    @Published var activeCity: String? = nil
    
    @ObservedObject var locationProvider: LocationProvider
    
    private let apiProvider = APIProvider()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        locationProvider = LocationProvider()
        locationProvider.startLocation()
        locationProvider.locationPublisher.sink { completion in
            self.districtCode = self.getDistrictCode(self.placeCity)
            self.activeCity = self.placeCity
            
            if let code = self.districtCode {
                self.saveLocationPlace(code)
            }
        } receiveValue: { (placeProvince, placeCity, placeDistrict) in
            self.placeProvince = placeProvince
            self.placeCity = placeCity
            self.placeDistrict = placeDistrict
        }.store(in: &subscriptions)
    }
    
    func getDistrictCode(_ name: String) -> Int64? {
        if let districtCode = PlaceCSV.shared.getCityCode(name) {
            return Int64(districtCode)
        } else {
            return nil
        }
    }
    
    func saveLocationPlace (_ districtCode: Int64) -> Void {
        if !PersistenceProvider.shared.checkEntityHasData(NSPredicate(format: "districtCode == %d", districtCode)) {
            let place = Place(context: PersistenceProvider.shared.managedObjectContext)
            place.districtCode = districtCode
            place.city = self.placeCity
            place.province = self.placeProvince
            place.district = self.placeDistrict
            place.createdAt = Date()
           
            PersistenceProvider.shared.saveContext()
        }
    }
}

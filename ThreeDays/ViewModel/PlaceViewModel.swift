//
//  PlaceViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/24.
//

import SwiftUI
import Combine

class PlaceViewModel: ObservableObject {
    @Published var activePlace: Place? = nil
    @Published var appPlace: PlaceCSV.Area? = nil
    
    @ObservedObject var locationProvider: LocationProvider
    
    private let apiProvider = APIProvider()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        locationProvider = LocationProvider()
        locationProvider.startLocation()
        locationProvider.locationPublisher.sink { completion in
            if let code = self.appPlace?.districtCode {
                self.saveAppLocation(code)
            }
        } receiveValue: { place in
            self.appPlace = place
        }.store(in: &subscriptions)
    }
    
    func getDistrictCode(_ name: String) -> Int64? {
        if let districtCode = PlaceCSV.shared.getCityCode(name) {
            return districtCode
        } else {
            return nil
        }
    }
    
    func saveAppLocation(_ districtCode: Int64) -> Void {
        let result = PersistenceProvider.shared.fetchDataForEntity(NSPredicate(format: "isAppLocation == %d", true))
        
        let place = result.count == 0 ? Place(context: PersistenceProvider.shared.managedObjectContext) : result[0]
        place.districtCode = districtCode
        place.city = self.appPlace?.city
        place.province = self.appPlace?.province
        place.district = self.appPlace?.district
        place.createdAt = Date()
        place.isAppLocation = true
        
        let defaults = UserDefaults.standard
        
        if let code = defaults.string(forKey: "activedDistrictCode") {
            let result = PersistenceProvider.shared.fetchDataForEntity(NSPredicate(format: "districtCode == %d", Int64(code)!))
            self.activePlace = result.count == 0 ? place : result[0]
        } else {
            defaults.set(districtCode, forKey: "activedDistrictCode")
            self.activePlace = place
        }
        
        PersistenceProvider.shared.saveContext()
    }
    
    func removePlace(_ item: Place) {
        PersistenceProvider.shared.managedObjectContext.delete(item)
        PersistenceProvider.shared.saveContext()
    }
    
    func addPlace(_ item: PlaceCSV.Area) {
        if !PersistenceProvider.shared.checkEntityHasData(NSPredicate(format: "districtCode == %d", item.districtCode)) {
            let place = Place(context: PersistenceProvider.shared.managedObjectContext)
            
            place.districtCode = item.districtCode
            place.city = item.city
            place.province = item.province
            place.district = item.district
            place.createdAt = Date()
            place.isAppLocation = false
            
            PersistenceProvider.shared.saveContext()
        }
    }
}

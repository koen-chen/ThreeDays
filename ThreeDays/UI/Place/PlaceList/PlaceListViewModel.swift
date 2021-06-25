//
//  PlaceListViewModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/24.
//

import SwiftUI
import Combine
import CoreData

class PlaceListViewModel: ObservableObject {
    @Published var activePlace: Place? = nil
    @Published var appPlace: ChinaPlace.Place? = nil
    @ObservedObject var locationService = LocationService<ChinaPlace.Place>()
    
    private var subscriptions = Set<AnyCancellable>()
    static let placeSubject = PassthroughSubject<String?, Never>()
    static var placePublisher: AnyPublisher<String?, Never> = placeSubject.eraseToAnyPublisher()
    
    init() {
        locationService.startLocation()
        locationService.locationPublisher.sink { completion in
            if let id = self.appPlace?.placeID {
                self.saveAppLocation(id)
            }
            self.locationService.cancelLocation()
        } receiveValue: { place in
            self.appPlace = place
        }.store(in: &subscriptions)
    }
    
    func getPlaceID(_ name: String) -> String? {
        if let placeID = ChinaPlace.shared.getPlaceId(name) {
            return placeID
        } else {
            return nil
        }
    }
    
    func changeActivePlace(_ place: Place) -> Void {
        UserDefaultsService.shared.save(activePlace: place.placeID!)
        self.activePlace = place
        Self.placeSubject.send(self.activePlace?.placeID)
    }
    
    func saveAppLocation(_ placeID: String) -> Void {
        let result = PersistenceService.shared.fetchDataForEntity(NSPredicate(format: "isAppLocation == %d", true))
        
        let place = result.count == 0 ? Place(context: PersistenceService.shared.managedObjectContext) : result[0]
        place.placeID = placeID
        place.cityCN = self.appPlace?.cityCN
        place.provinceCN = self.appPlace?.provinceCN
        place.regionCN = self.appPlace?.regionCN
        place.createdAt = Date()
        place.isAppLocation = true
        
        if let code = UserDefaultsService.shared.fetchActivePlace() {
            let result = PersistenceService.shared.fetchDataForEntity(NSPredicate(format: "placeID == %@", code))
            self.activePlace = result.count == 0 ? place : result[0]
        } else {
            UserDefaultsService.shared.save(activePlace: placeID)
            self.activePlace = place
        }
        
        Self.placeSubject.send(self.activePlace?.placeID)
        
        PersistenceService.shared.saveContext()
    }
    
    func removePlace(_ item: Place) {
        PersistenceService.shared.managedObjectContext.delete(item)
        PersistenceService.shared.saveContext()
    }
    
    func addPlace(_ item: ChinaPlace.Place) {
        if !PersistenceService.shared.checkEntityHasData(NSPredicate(format: "placeID == %@", item.placeID)) {
            let place = Place(context: PersistenceService.shared.managedObjectContext)
            
            place.placeID = item.placeID
            place.cityCN = item.cityCN
            place.provinceCN = item.provinceCN
            place.regionCN = item.regionCN
            place.createdAt = Date()
            place.isAppLocation = false
            
            PersistenceService.shared.saveContext()
        }
    }
}

//
//  LocationFetcher.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/8.
//

import SwiftUI
import CoreLocation
import Combine

class LocationProvider: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
   
    @Published var authorizationStatus: CLAuthorizationStatus?
    let locationSubject: PassthroughSubject<(String, String, String), Never>
    var locationPublisher: AnyPublisher<(String, String, String), Never>
    
    func requestAuthorization () {
        manager.requestWhenInUseAuthorization()
    }
    
    func authorizationStatusString() -> String {
        switch self.authorizationStatus {
            case .authorizedWhenInUse:
                return "ALlowed When in Use"
            case .notDetermined:
                return "Not Determined"
            case .restricted:
                return "Restricted"
            case .denied:
                return "Denied"
            case .authorizedAlways:
                return "Authorized Always"
            case .none:
                return "unknown"
            default:
                return "unknown"
        }
    }
    
    override init() {
        manager.distanceFilter = 3000
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        
        locationSubject = PassthroughSubject<(String, String, String), Never>()
        locationPublisher = locationSubject.eraseToAnyPublisher()
        
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func startLocation () {
        manager.startUpdatingLocation()
    }
    
    func cancelLocation () {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let gecoder = CLGeocoder()
        if let location = location {
            gecoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "zh_CN")) { (placeMarks, error) in
                let placeMark = placeMarks?.first
                if let placeMark = placeMark {
                    let placeName = placeMark.name ?? ""
                    let placeCountry = placeMark.country ?? ""
                    let placeLocality = placeMark.locality ?? ""
                    
                    print("place:", (placeName, placeLocality, placeCountry))
                    self.locationSubject.send((placeName, placeLocality, placeCountry))
                    self.locationSubject.send(completion: .finished)
                }
            }
        }
        
        cancelLocation()
    }
}

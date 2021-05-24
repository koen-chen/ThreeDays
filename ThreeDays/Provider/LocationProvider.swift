//
//  LocationProvider.swift
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
                let placeMark = placeMarks?.last
                if let placeMark = placeMark {
                    let placeProvince = placeMark.administrativeArea ?? ""
                    let placeCity = placeMark.locality ?? ""
                    let placeDistrict = placeMark.subLocality ?? placeCity
                   
                    print("place:", (placeProvince, placeCity, placeDistrict))
                    self.locationSubject.send((placeProvince, placeCity, placeDistrict))
                    
                    self.locationSubject.send(completion: .finished)
                }
            }
        }
        
        cancelLocation()
    }
}

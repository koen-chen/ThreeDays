//
//  LocationCSV.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/1.
//

import SwiftUI
import CodableCSV

class ChinaPlace: ObservableObject {
    static let shared = ChinaPlace()
    private var allPlace = [ChinaPlace.Place]()
    
    struct Place: Codable, Hashable {
        var placeID: String
        var regionCN: String
        var cityCN: String
        var provinceCN: String
        var countryCN: String
    }
    
    private init() {
        let filePath = Bundle.main.path(forResource: "China-Place-List", ofType: "csv")
        let decoder = CSVDecoder {
            $0.headerStrategy = .firstLine
            $0.bufferingStrategy = .sequential
        }
        
        do {
            let content = try decoder.decode([ChinaPlace.Place].self, from: URL(fileURLWithPath: filePath!))
            self.allPlace = content
        } catch {
            print(error)
        }
    }
    
    func getPlaceId(_ name: String) -> String? {
        let result = self.allPlace.first { item in
            item.regionCN == name || item.cityCN == name
        }
        
        guard let place = result else {
            return nil
        }
        
        return place.placeID
    }
    
    func searchPlace(_ name: String, field: String = "region") -> [ChinaPlace.Place] {
        return self.allPlace.filter { item in
            if field == "city" {
                if item.cityCN.contains(name) || name.contains(item.cityCN){
                    return true
                } else {
                    return false
                }
            } else {
                if item.regionCN.contains(name) || name.contains(item.regionCN) {
                    return true
                } else {
                    return false
                }
            }
        }
    }
    
    func getAllPlace() -> [ChinaPlace.Place] {
        return self.allPlace
    }
}


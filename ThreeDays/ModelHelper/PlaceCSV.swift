//
//  PlaceCSV.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/23.
//

import SwiftUI
import CodableCSV

class PlaceCSV: ObservableObject {
    static let shared = PlaceCSV()
    private var placeList = [Area]()
    
    struct Area: Codable, Hashable {
        var districtCode: Int64
        var city: String
        var district: String
        var province: String
    }
    
    private init() {
        let filePath = Bundle.main.path(forResource: "full-place", ofType: "csv")
        let decoder = CSVDecoder {
            $0.headerStrategy = .firstLine
            $0.bufferingStrategy = .sequential
        }

        let content = try! decoder.decode([Area].self, from: URL(fileURLWithPath: filePath!))
        self.placeList = content
    }
    
    func getCityCode(_ cityName: String) -> Int64? {
        let result = self.placeList.first { item in
            item.city == cityName
        }
        
        guard let city = result else {
            return nil
        }
        
        return city.districtCode
    }
    
    func searchPlace(_ name: String, field: String = "district") -> [Area] {
        return self.placeList.filter { item in
            if field == "city" {
                if item.city.contains(name) {
                    return true
                } else {
                    return false
                }
            } else {
                if item.district.contains(name) {
                    return true
                } else {
                    return false
                }
            }

        }
    }
    
    func getPlaceList() -> [Area] {
        return self.placeList
    }
}


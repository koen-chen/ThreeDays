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
    private var placeList = [PlaceModel]()
    
    private init() {
        let filePath = Bundle.main.path(forResource: "full-place", ofType: "csv")
        let decoder = CSVDecoder {
            $0.headerStrategy = .firstLine
            $0.bufferingStrategy = .sequential
        }
        
        let content = try! decoder.decode([PlaceModel].self, from: URL(fileURLWithPath: filePath!))
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
    
    func searchPlace() {
        
    }
    
    func getPlaceList() -> [PlaceModel] {
        return self.placeList
    }
}

//
//  CitySource.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/23.
//

import SwiftUI
import CodableCSV

class CitySource: ObservableObject {
    static let shared = CitySource()
    
    static var cityCodeList: [CityModel] {
        let filePath = Bundle.main.path(forResource: "adcodes", ofType: "csv")
        let decoder = CSVDecoder {
            $0.headerStrategy = .firstLine
            $0.bufferingStrategy = .sequential
        }
    
        let content = try! decoder.decode([CityModel].self, from: URL(fileURLWithPath: filePath!))
        return content
    }
    
    static func getCityCode(_ cityName: String) -> Int? {
        let result = Self.cityCodeList.first { item in
            item.name == cityName
        }
        
        guard let city = result else {
            return nil
        }
        
        return city.adcode / 1000000
    }
}

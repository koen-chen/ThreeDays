//
//  LocationModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/9.
//

import Foundation

struct LocationModel: Codable {
    struct Result: Codable {
        var name: String
        var adcode: String
    }
   
    var results: [Result]
}

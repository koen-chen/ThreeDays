//
//  PlaceModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import Foundation

struct PlaceModel: Codable {
    var districtCode: Int64
    var city: String
    var district: String?
    var province: String?
    var createdAt: Date?
}


//
//  PlaceModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import Foundation

struct PlaceModel: Codable, Hashable {
    var districtCode: Int64
    var city: String
    var district: String
    var province: String
    var isAppLocation: Bool?
    var createdAt: Date?
}


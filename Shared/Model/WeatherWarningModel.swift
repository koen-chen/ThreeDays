//
//  WeatherWarningModel.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/7/1.
//

import Foundation

struct WeatherWarningModel: Codable {
    struct Warning: Codable {
        var sender: String?
        var pubTime: String
        var title: String
        var status: String?
        var level: String
        var type: String
        var typeName: String
        var text: String
    }
    
    var warning = [Warning]()
    var code: String
    var updateTime: String
}

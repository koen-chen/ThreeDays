//
//  WeatherNowMediumView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/26.
//

import SwiftUI

struct WeatherNowMediumView: View {
    @EnvironmentObject var theme: Theme
    let nowWeather: WeatherNowModel?
    let dailyWeather: WeatherDailyModel?
    let activePlaceName: String?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

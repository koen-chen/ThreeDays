//
//  ThreeDaysWidget.swift
//  ThreeDaysWidget
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct ThreeDaysWidget: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
        WeatherNowWidget()
        WeatherDailyWidget()
    }
}

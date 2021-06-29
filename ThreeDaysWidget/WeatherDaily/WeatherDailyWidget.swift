//
//  WeatherDailyWidget.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import SwiftUI
import WidgetKit

struct WeatherDailyWidget: Widget {
    let kind: String = "WeatherDailyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetTimelineProvider()) { entry in
            WeatherDailyWidgetView(entry: entry)
                .environmentObject(Theme())
        }
        .configurationDisplayName("3日天气")
        .description("青山一道同云雨，明月何曾是两乡")
        .supportedFamilies([.systemLarge])
    }
}

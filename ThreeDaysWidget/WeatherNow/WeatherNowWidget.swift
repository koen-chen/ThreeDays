//
//  WeatherNowWidget.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import SwiftUI
import WidgetKit

struct WeatherNowWidget: Widget {
    let kind: String = "WeatherNowWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: WidgetTimelineProvider()) { entry in
            WeatherNowWidgetView(entry: entry)
                .environmentObject(Theme())
        }
        .configurationDisplayName("今日天气")
        .description(Theme().isDaytime ? "山川异域，风月同天" : "云月是同，溪山各异")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

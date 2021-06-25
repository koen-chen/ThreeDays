//
//  WeatherDailyWidgetView.swift
//  ThreeDaysWidgetExtension
//
//  Created by koen.chen on 2021/6/25.
//

import WidgetKit
import SwiftUI

struct WeatherDailyWidgetView: View {
    var entry: WidgetTimelineProvider.Entry
    
    @Environment(\.widgetFamily) private var family: WidgetFamily
    
    var body: some View {
        Text("Large View")
//        switch family {
//            case .systemSmall, .systemMedium:
//                WidgetNotAvailableView()
//            case .systemLarge:
//                Text("aaa")
//            @unknown default:
//                WidgetNotAvailableView()
//        }
    }
}

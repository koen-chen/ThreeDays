//
//  LottieView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/6.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    @EnvironmentObject var theme: Theme
    
    typealias completionClosure = (_ status: Bool) -> Void
    static var cacheName = ""
    
    var name: String = ""
    var loopMode: LottieLoopMode = .loop
    var isWeather: Bool = false
    var weatherDesc: String = ""
    var loopWay: LottieLoopMode = .loop
    let animationView = AnimationView()
    var completion: completionClosure?
    
    var weatherIcon: String {
        switch weatherDesc {
            case "晴":
                return "clear-sky"
            case "多云":
                return "scattered-clouds"
            case "阴":
                return "few-clouds"
            case "雨", "雨夹雪", "小雨", "中雨", "大雨", "暴雨", "大暴雨", "冻雨":
                return "rain"
            case "阵雨":
                return "shower-rains"
            case "雷阵雨":
                return "thunderstorm"
            case "雪", "阵雪", "小雪", "中雪", "大雪", "暴雪", "高吹雪":
                return "snow"
            case "雾", "浓雾", "强浓雾", "轻雾", "霾", "中度霾", "重度霾", "严重霾", "大雾":
                return "mist"
            case "沙尘暴", "浮尘", "扬沙", "龙卷风":
                return "wind"
            default:
                return ""
        }
    }
    
    var weatherName: String {
        return "weather-\(theme.iconText)-\(weatherIcon)"
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        LottieView.cacheName = isWeather ? weatherName : name
        
        let view = UIView(frame: .zero)
        animationView.animation = Animation.named(isWeather ? weatherName : name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopWay
        animationView.backgroundBehavior = .pauseAndRestore
       
        animationView.play { (status) in
            if let completionFunc = completion {
                completionFunc(status)
            }
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        if isWeather && LottieView.cacheName != weatherName {
            LottieView.cacheName = weatherName
            context.coordinator.parent.animationView.animation = Animation.named(weatherName)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: LottieView
        
        init(_ parent: LottieView) {
            self.parent = parent
        }
    }
}

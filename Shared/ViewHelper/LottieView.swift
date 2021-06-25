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
  
    static var cacheName = ""
    var name: String = ""
    var loopMode: LottieLoopMode = .loop
    var isWeather: Bool = false
    var weatherCode: String?
    var loopWay: LottieLoopMode = .loop
    let animationView = AnimationView()
   
    var weatherIcon: String {
        return Description.weatherLottieIcon(weatherCode)
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
        animationView.play()
    
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
        
        context.coordinator.parent.animationView.play()
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

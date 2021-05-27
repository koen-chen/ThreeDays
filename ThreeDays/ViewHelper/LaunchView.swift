//
//  LaunchView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/27.
//

import SwiftUI
import Combine

struct LaunchView: View {
    @EnvironmentObject var theme: Theme
    
    static let lottieSubject = PassthroughSubject<Bool, Never>()
    static var lottiePublisher: AnyPublisher<Bool, Never> = lottieSubject.eraseToAnyPublisher()
    
    var body: some View {
        ZStack {
            Spacer()
            
            LottieView(
                name: "loading-\(theme.iconText)",
                loopWay: .playOnce,
                completion: { status in
                    Self.lottieSubject.send(status)
                }
            )
            .frame(width: 200, height: 200)
            .padding()
            
            Spacer()
        }
        .frame(width: screen.width, height: screen.height)
        .background(BlurView(style: .systemMaterial).background(theme.backgroundColor))
        .ignoresSafeArea()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(Theme())
    }
}

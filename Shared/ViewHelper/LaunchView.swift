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
    @StateObject var netMonitor = NetworkService()
    
    var body: some View {
        ZStack {
            Spacer()
            
            VStack {
                LottieView(name: "loading-\(theme.iconText)")
                .frame(width: 200, height: 200)
                    .padding()
                
                if netMonitor.status == .disconnected {
                    Text("网络连接异常 \n 请检查网络后重启应用")
                        .multilineTextAlignment(.center)
                        .font(.custom(theme.font, size: 24))
                        .foregroundColor(theme.textColor)
                }
            }
            
            Spacer()
        }
        .frame(width: theme.screen.width, height: theme.screen.height)
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

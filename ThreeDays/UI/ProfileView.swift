//
//  ProfileView.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/6/7.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.openURL) var openURL

    @Binding var showProfileView: Bool
    @State var showOperatetionGuide: Bool = false
    @State var showShareSheet: Bool = false
    
    let shareLink = "https://www.apple.com"

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                showOperatetionGuide = false
                showShareSheet = false
                showProfileView.toggle()
            }, label: {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 18))
                    .padding(.all, 10)
            })
            
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    Divider().background(theme.backgroundColor).padding(.vertical, 10)
                    
                    Text("操作说明")
                        .onTapGesture(perform: {
                            showOperatetionGuide.toggle()
                        })
                    
                    if showOperatetionGuide {
                        OperatetionGuideView()
                    }
                    
                    Divider().background(theme.backgroundColor).padding(.vertical, 10)
                    
                    Text("建议评分")
                        .onTapGesture(perform: {
                            openURL(URL(string: shareLink)!)
                        })
                    
                    Divider().background(theme.backgroundColor).padding(.vertical, 10)
                    
                    Text("分享推荐")
                        .onTapGesture(perform: {
                            showShareSheet.toggle()
                        })
                        .sheet(isPresented: $showShareSheet) {
                            ShareSheet(activityItems: ["三日天气", URL(string: shareLink)!])
                        }
                    
                    Divider().background(theme.backgroundColor).padding(.vertical, 10)
                    
                    Text("当前版本：1.0.0")
                        .font(.custom(theme.font, size: 14))
                    
                    Spacer()
                }
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 50)
        .font(.custom(theme.font, size: 20))
        .foregroundColor(theme.textColor)
        .shadow(color: theme.textColor.opacity(0.2), radius: 2, x: 0, y:  5)
        .animation(.easeInOut)
        .background(BlurView(style: .systemMaterial).background(theme.backgroundColor).ignoresSafeArea())
    }
}

struct OperatetionGuideView: View {
    @EnvironmentObject var theme: Theme

    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            GuideItem(icon: "gesture-click", desc: "触发日历和城市面板") {
                HStack(alignment: .center) {
                    Text("单击图标")
                    Image(systemName: "circle.righthalf.fill")
                    Text("或者")
                    Image(systemName: "circle.lefthalf.fill")
                }
            }
            
            GuideItem(icon: "gesture-click", desc: "查看天气详情") {
                HStack(alignment: .center) {
                    Text("单击天气图标")
                    LottieView(isWeather: true, weatherCode: "100")
                        .frame(width: 40, height: 40)
                }
            }
            
            GuideItem(icon: "gesture-up", desc: "触发城市管理面板") {
                Text("向上滑动屏幕")
            }
            
            GuideItem(icon: "gesture-down", desc: "触发日历选择面板") {
                Text("向下滑动屏幕")
            }
            
            GuideItem(icon: "gesture-left", desc: "查看3日天气概览") {
                Text("向左滑动屏幕")
            }
            
            GuideItem(icon: "gesture-right", desc: "查看操作说明") {
                Text("向右滑动屏幕")
            }
        }
        .padding(.horizontal, 10)
        .foregroundColor(theme.textColor)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showProfileView: .constant(false))
            .environmentObject(Theme())
    }
}

struct GuideItem<Content: View>: View {
    var icon: String
    var desc: String
    var label: Content
    
    init(icon: String, desc:String, @ViewBuilder content: @escaping () -> Content) {
        self.icon = icon
        self.desc = desc
        self.label = content()
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(icon)
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
            
            VStack(alignment: .leading, spacing: 10) {
                label
                Text(desc)
            }
        }
    }
}

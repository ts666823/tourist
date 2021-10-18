//
//  HomeView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/18.
//

import SwiftUI

struct HomeView: View {
    @State var selectedView = 1
    
    
    var body: some View {
        TabView(selection: $selectedView) {
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("天气预报")
            }
            .tag(1)
            ScenicView()
                .tabItem {
                    Image(systemName: "giftcard")
                    Text("信息查询")
            }
            .tag(2)
            HistoryTodayView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("那年今日")
            }
            .tag(2)
            CookBookView()
                .tabItem {
                    Image(systemName: "book")
                    Text("菜谱大全")
            }
            .tag(2)
        }
        .accentColor(.black)
        .edgesIgnoringSafeArea(.top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

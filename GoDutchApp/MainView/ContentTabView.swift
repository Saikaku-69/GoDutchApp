//
//  TabView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/06.
//

import SwiftUI

struct ContentTabView: View {
    @State private var selectedTabIndex:Int = 1
    
    var body: some View {
        TabView(selection:$selectedTabIndex) {
            ContentView()
                .tabItem {
                    Label("Home",systemImage: "house")
                }
                .tag(1)
            
            HistoryPayView()
                .tabItem {
                    Label("歴史",systemImage: "clock")
                }
                .tag(2)
        }
    }
}

#Preview {
    NavigationView {
        ContentTabView()
    }
}

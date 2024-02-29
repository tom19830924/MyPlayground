//
//  MainTab.swift
//  PokeMaster
//
//  Created by user on 2024/2/22.
//

import SwiftUI

struct MainTab: View {
    var body: some View {
        TabView {
            PokemonRootView()
                .tabItem {
                    Image(systemName: "list.bullet.below.rectangle")
                    Text("列表")
                }
            SettingRootView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("設置")
                }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    MainTab()
}

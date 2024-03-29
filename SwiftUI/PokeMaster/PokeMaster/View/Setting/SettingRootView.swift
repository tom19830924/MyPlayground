//
//  SettingRootView.swift
//  PokeMaster
//
//  Created by user on 2024/2/7.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView()
                .navigationTitle("設置")
        }
    }
}

#Preview {
    SettingRootView()
}

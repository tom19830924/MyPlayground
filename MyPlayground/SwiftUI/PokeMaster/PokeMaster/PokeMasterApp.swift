//
//  PokeMasterApp.swift
//  PokeMaster
//
//  Created by user on 2024/2/7.
//

import SwiftUI

@main
struct PokeMasterApp: App {
    var body: some Scene {
        WindowGroup {
            MainTab().environmentObject(Store())
        }
    }
}

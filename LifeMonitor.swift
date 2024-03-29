//
//  LifeMonitor.swift
//  AAA
//
//  Created by user on 2024/1/25.
//

import Foundation

class LifeMonitor {
    let name: String

    init<T>(type: T.Type) {
        self.name = String(describing: type.self)
    }

    deinit {
        print("\(name) deinit")
    }
}

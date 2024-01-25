//
//  CombineView.swift
//  MyPlayground
//
//  Created by user on 2024/1/2.
//

import SwiftUI
import Combine

struct CombineView: View {
    var body: some View {
        VStack {
            Button("Test") {
                let publisher = Just(5)
                let publisherString = publisher.map { $0.description }
                let publisherDouble = publisher.map { Double($0) }
                let subcriber = publisher.sink(receiveValue: { print($0) })
            }
        }
    }
    
    func add(left: Int, right: Int) -> Int {
        return left + right
    }
}

#Preview {
    CombineView()
}

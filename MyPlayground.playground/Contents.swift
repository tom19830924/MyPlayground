import Foundation
import Combine
import UIKit
import SwiftUI
import PlaygroundSupport
import AVFoundation

PlaygroundPage.current.setLiveView(ContentView())

import SwiftUI

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

struct ContentView: View {
    var body: some View {
        MyView()
            .padding()
            .task {
                print("3")
                print("4")
            }
            .debug()
       
    }
}

struct MyView: View {
    var body: some View {
        Text("123")
            .task {
                print("1")
                print("2")
            }
            .debug()
    }
}

#Preview {
    ContentView()
}

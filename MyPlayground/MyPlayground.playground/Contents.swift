import Foundation
import Combine
import UIKit
import SwiftUI
import PlaygroundSupport

PlaygroundPage.current.setLiveView(ContentView())
struct ContentView: View {
    var body: some View {
        Text("HelloWorld")
    }
}

let p = PassthroughSubject<Int, Never>()

p.send(1)
p.send(2)


p.sink { i in
    print(i)
}


p.send(3)

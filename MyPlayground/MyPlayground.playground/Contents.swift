import Foundation
import Combine
import UIKit
import SwiftUI
import PlaygroundSupport

PlaygroundPage.current.setLiveView(ContentView())
struct ContentView: View {
    var a = DateInterval(start: Date(), end: Date(timeIntervalSinceNow: 3600))
    var hello = "HelloWorld"
    var body: some View {
        Text(hello)
        Text("HelloWorld")
        
        Text("Date: \(Date(), style: .date)")
        Text("Meeting: \(a)")
    }
}

let p = PassthroughSubject<Int, Never>()

p.send(1)
p.send(2)


p.sink { i in
    print(i)
}


p.send(3)

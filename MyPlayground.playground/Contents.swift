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

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    var body: some View {
        VStack {
            Button("Present") {
                isPresented = true
            }
        }
        .sheet(isPresented: $isPresented) {
            FullScrenPresentedView()
        }
    }
}

struct FullScrenPresentedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("view4")
                SubView()
            }
            .padding()
            .border(.red)
        }
    }
}

struct SubView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button("Dismiss") {
                dismiss()
            }
        }
        .border(.green)
    }
}

#Preview {
    ContentView()
}

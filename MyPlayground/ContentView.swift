import SwiftUI
import AVFoundation

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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Dismiss") {
                    print(presentationMode.wrappedValue.isPresented)
                }
                SubView()
            }
            .padding()
            .border(.red)
        }
        .debug()
    }
}

struct SubView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Button("Dismiss") {
                print(presentationMode.wrappedValue.isPresented)
            }
        }
        .border(.green)
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}

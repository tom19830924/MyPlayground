import SwiftUI

struct ContentView: View {
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .frame(minWidth: 200)
            .debug()
    }
}

#Preview {
    ContentView()
}

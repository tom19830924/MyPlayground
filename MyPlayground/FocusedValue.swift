import SwiftUI

struct FocusedMessageKey: FocusedValueKey {
    typealias Value = Binding<String>
}

extension FocusedValues {
    var message: Binding<String>? {
        get { self[FocusedMessageKey.self] }
        set { self[FocusedMessageKey.self] = newValue }
    }
}

struct InputView1: View {
    @State private var text = ""
    var body: some View {
        VStack {
            TextField("input1:", text: $text)
                .textFieldStyle(.roundedBorder)
                .focusedValue(\.message, $text)
        }
    }
}

struct InputView2: View {
    @State private var text = ""
    var body: some View {
        TextField("input2:", text: $text)
            .textFieldStyle(.roundedBorder)
            .focusedValue(\.message, $text)
    }
}

struct ShowView: View {
    @FocusedValue(\.message) var focusMessage
    
    var body: some View {
        VStack {
            Text("focused: \(focusMessage?.wrappedValue ?? "")")
        }
    }
}

#Preview {
    struct ContentView: View {
        var body: some View {
            VStack(spacing: 25) {
                ShowView()
                InputView1()
                InputView2()
            }
            .padding(.all, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    return ContentView()
}

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
                .environment(\.isPresented, $isPresented)
        }
    }
}

struct FullScrenPresentedView: View {
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                view1
                    .border(.red)
                view2
                    .border(.green)
                view3
                    .border(.blue)
                view4
                    .border(.orange)
            }
            .padding()
            .border(.red)
        }
    }
    
    var view1: some View {
        VStack {
            Text("view1")
            Button("Dismiss") {
//                presentationMode.wrappedValue.dismiss()
                dismiss()
            }
        }
    }

    var view2: some View {
        NavigationLink {
            Button("Dismiss") {
//                presentationMode.wrappedValue.dismiss()
                dismiss()
            }
        } label: {
            VStack {
                Text("view2")
                Text("Push Next")
            }
        }
    }

    var view3: some View {
        NavigationLink {
            SubView()
        } label: {
            VStack {
                Text("view3")
                Text("Push Next")
            }
        }
    }

    var view4: some View {
        VStack {
            Text("view4")
            SubView()
        }
    }
}

struct SubView: View {
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
//    @Environment(\.isPresented) var isPresented: Binding<Bool>
    
    var body: some View {
        VStack {
            Button("Dismiss") {
//                presentationMode.wrappedValue.dismiss()
                dismiss()
            }
//            Button("Dismiss") {
//                isPresented.wrappedValue.toggle()
//            }
        }
        .border(.green)
    }
}

#Preview {
    ContentView()
}

private struct IsPresented: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var isPresented: Binding<Bool> {
        get { self[IsPresented.self] }
        set { self[IsPresented.self] = newValue }
    }
}

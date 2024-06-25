import SwiftUI

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth / 2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

private struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }
}


struct KnobView: View {
    @Binding var value: Double
    var pointerSize: CGFloat?
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.knobPointerSize) var envPointerSize
    
    var body: some View {
        KnobShape(pointerSize: pointerSize ?? envPointerSize)
            .fill(colorScheme == .dark ? .white : .black)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    value = value < 0.5 ? 1 : 0
                }
            }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        environment(\.knobPointerSize, size)
    }
}

#Preview {
    struct ContentView: View {
        @State var value = 0.5
        @State var balance = 0.5
        var body: some View {
            HStack {
                VStack {
                    Text("Volume")
                    KnobView(value: $value)
                        .frame(width: 100, height: 100)
                }
                VStack {
                    Text("Balance")
                    KnobView(value: $balance)
                        .frame(width: 100, height: 100)
                }
            }
            .knobPointerSize(0.1)
        }
    }
    return ContentView()
}

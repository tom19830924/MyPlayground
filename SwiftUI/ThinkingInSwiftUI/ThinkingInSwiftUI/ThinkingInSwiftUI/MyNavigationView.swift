import SwiftUI

struct MyNavigationTitleKey: PreferenceKey {
    static var defaultValue: String?
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = value ?? nextValue()
    }
}

extension View {
    func myNavigationTitle(_ title: String) -> some View {
        preference(key: MyNavigationTitleKey.self, value: title)
    }
}

struct MyNavigationView<Content>: View where Content: View {
    let content: Content
    @State private var title: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            Text(title ?? "")
            content
                .onPreferenceChange(MyNavigationTitleKey.self) { title in
                    self.title = title
                }
        }
    }
}

#Preview {
    MyNavigationView {
        Text("Hello")
            .myNavigationTitle("Rootview")
            .background(.gray)
    }
    .debug()
}

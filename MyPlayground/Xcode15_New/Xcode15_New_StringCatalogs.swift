import SwiftUI

// 新的多語系管理方式, 向下相容
// Xcode14可使用此工具來編輯, https://github.com/igorkulman/iOSLocalizationEditor
struct Xcode15_New_StringCatalogs: View {
    var body: some View {
        VStack {
            Text("hello-world")
        }
        
    }
}

#Preview {
    Xcode15_New_StringCatalogs()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview {
    Xcode15_New_StringCatalogs()
        .environment(\.locale, .init(identifier: "zh-hant"))
}

#Preview {
    Xcode15_New_StringCatalogs()
        .environment(\.locale, .init(identifier: "de"))
}

#Preview {
    Xcode15_New_StringCatalogs()
}

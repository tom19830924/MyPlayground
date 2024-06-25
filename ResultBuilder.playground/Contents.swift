import UIKit
import SwiftUI
import PlaygroundSupport
PlaygroundPage.current.setLiveView(ContentView())

@resultBuilder
struct AttributedStringBuilder {
    static func buildBlock() -> AttributedString {
        print("\(#function)")
        return .init("")
    }
    
    static func buildBlock(_ components: AttributedString...) -> AttributedString {
        print("\(#function)")
        return components.reduce(into: AttributedString("")) { result, next in
            result.append(next)
        }
    }
}

@AttributedStringBuilder var myFirstText: AttributedString {
    AttributedString("Hello")
    AttributedString("World")
}
// Example:
//print(myFirstText)

@AttributedStringBuilder
func mySecondText() -> AttributedString {}

// Example:
// mySecondText()

func generateText(@AttributedStringBuilder _ content: () -> AttributedString) -> Text {
    Text(content())
}
// Example:
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            generateText {
//                AttributedString("Hello")
//                AttributedString(" World")
//            }
//        }
//    }
//}

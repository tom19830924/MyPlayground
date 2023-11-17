//: [Previous](@previous)

import UIKit
import SwiftUI
import PlaygroundSupport

// UIKit
let image = UIImage(named: "image")!
let imageView = UIImageView(image: image)
imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
imageView.backgroundColor = .white
imageView.alpha = 0.5
//PlaygroundPage.current.liveView = imageView

// SwiftUI
struct ContentView: View {
    var body: some View {
        Image(uiImage: image)
            .frame(width: 256, height: 256)
            .background(Color.white)
            .opacity(0.5)
    }
}
//PlaygroundPage.current.setLiveView(ContentView())

// Fluent Interface for UIKit
extension UIImageView {
    func frame(_ rect: CGRect) -> Self {
        self.frame = rect
        return self
    }
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
}

let fluentImageView = UIImageView(image: image)
    .frame(CGRect(x: 0, y: 0, width: 100, height: 100))
    .backgroundColor(.white)
    .alpha(0.5)



@dynamicMemberLookup
struct FluentInterface<Subject> {
    let subject: Subject
        
    // 因為要動到 subject 的屬性，所以 keyPath 的型別必須是 WritableKeyPath
    // 回傳值是一個 Setter 方法
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Subject, Value>) -> ((Value) -> FluentInterface<Subject>) {

        // 因為在要回傳的 Setter 方法裡不能更改 self，所以要把 subject 從 self 取出來用
        var subject = self.subject

        // subject 實體的 Setter 方法
        return { value in

            // 把 value 指派給 subject 的屬性
            subject[keyPath: keyPath] = value

            // 回傳的型別是 FluentInterface<Subject> 而不是 Subject
            // 因為現在的流暢界面是用 FluentInterface 型別來串，而不是 Subject 本身
            return FluentInterface(subject: subject)
        }
    }
}

// ---------------------------------------------------------------------------

FluentInterface(subject: UILabel())
    .frame(CGRect(x: 1, y: 2, width: 3, height: 4))
    .text("Label")
    .backgroundColor(.white)
    .alpha(0.5)
    .subject

// ---------------------------------------------------------------------------

//extension UIResponder {
//    func fluent() -> FluentInterface<Self> {
//        FluentInterface(subject: self)
//    }
//}

protocol UIWrapper: UIResponder {}
extension UIWrapper {
    func fluent() -> FluentInterface<Self> {
        FluentInterface(subject: self)
    }
}
extension UIResponder: UIWrapper {}

extension FluentInterface {
    func interface() -> Subject {
        self.subject
    }
}

// ---------------------------------------------------------------------------

// 原本 + 只被用在 infix，所以需要另外宣告為 postfix 運算子
postfix operator +

// 把任何實體用 FluentInterface 包裝起來的函數
postfix func + <T>(lhs: T) -> FluentInterface<T> {
    return FluentInterface(subject: lhs)
}

// 同上
postfix operator -

// 把 FluentInterface 的內容取出的函數
// 也可以宣告成 FluentInterface 的 static 方法
postfix func - <T>(lhs: FluentInterface<T>) -> T {
    return lhs.subject
}

// ---------------------------------------------------------------------------

let lbl = UILabel()+
    .frame(CGRect(x: 1, y: 2, width: 3, height: 4))
    .text("Label")
    .backgroundColor(.white)
    .alpha(0.5)-
print(lbl, terminator: "\n\n")

let textField = UITextField()
    .fluent()
    .frame(CGRect(x: 5, y: 6, width: 7, height: 8))
    .text("TextField")
    .borderStyle(.bezel)
    .interface()
print(textField)
//: [Next](@next)

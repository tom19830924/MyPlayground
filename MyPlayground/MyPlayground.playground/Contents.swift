import Foundation
import Combine
import UIKit



class MyClass {
    func render<E>(_ name: String, _ context: E) async -> String {
        print(type(of: context))
        return "HelloWorld"
    }
}


let myclass = MyClass()
let result = await myclass.render("123", UIView())

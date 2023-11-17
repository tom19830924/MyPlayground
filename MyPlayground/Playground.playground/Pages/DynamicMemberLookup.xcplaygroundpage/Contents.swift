//: [Previous](@previous) - [Table of Contents](Table_of_Contents)
//
//  main.swift
//  DynamicMemberLookup
//
//  Created by user on 2023/8/30.
//

import Foundation
import UIKit

class Person {
    var name: String
    var info: [String: Int]
    
    init(name: String, info: [String : Int]) {
        self.name = name
        self.info = info
    }
    
    subscript(index: String) -> Int? {
        info[index]
    }
}
extension Person: Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

var person1 = Person(name: "Tom", info: ["age": 20])
print(person1.name)
print(person1[keyPath: \.name])



// Swift 4.2 推出
@dynamicMemberLookup
struct DynamicPerson {
    var name: String
    var info: [String: Any]

    subscript(dynamicMember infoKey: String) -> Any? {
        get {
            return info[infoKey]
        }
        set {
            info[infoKey] = newValue
        }
    }
}

var dynamicPerson = DynamicPerson(name: "Tom", info: ["age": 21])
//print(dynamicPerson.age)
//print(dynamicPerson.WTF)

// Swift 5.1 dynamicMemberLookup support Key-Path






@dynamicMemberLookup
@dynamicCallable
final class NameCache {
    private var names: [String] = []
    
    subscript<T>(dynamicMember keyPath: KeyPath<[String], T>) -> T {
        let a = names[keyPath: keyPath]
        return a
    }
    
    @discardableResult
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, String>) -> Bool {
        for (key, value) in args {
            if key == "contains" {
                return names.contains(value)
            } else if key == "store" {
                names.append(value)
                return true
            }
        }
        return false
    }
}

let cache = NameCache()
//print(cache(contains: "Maaike"))
//print(cache(store: "Maaike"))
//print(cache(contains: "Maaike"))
//
//print(cache.count)
//print(cache.description)

@dynamicMemberLookup
struct FluentInterface<Subject> {
    let subject: Subject!
        
    // 因為要動到 subject 的屬性，所以 keyPath 的型別必須是 WritableKeyPath
    // 回傳值是一個 Setter 方法
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Subject, Value>) -> ((Value) -> FluentInterface<Subject>) {

        // 因為在要回傳的 Setter 方法裡不能更改 self，所以要把 subject 從 self 取出來用
        var subject = self.subject

        // subject 實體的 Setter 方法
        return { value in

            // 把 value 指派給 subject 的屬性
            subject![keyPath: keyPath] = value

            // 回傳的型別是 FluentInterface<Subject> 而不是 Subject
            // 因為現在的流暢界面是用 FluentInterface 型別來串，而不是 Subject 本身
            return FluentInterface(subject: subject)
        }
    }
}

//// 原本 + 只被用在 infix，所以需要另外宣告為 postfix 運算子
//postfix operator +
//
//// 把任何實體用 FluentInterface 包裝起來的函數
//postfix func + <T>(lhs: T) -> FluentInterface<T> {
//    return FluentInterface(subject: lhs)
//}
//
//// 同上
//postfix operator -
//
//// 把 FluentInterface 的內容取出的函數
//// 也可以宣告成 FluentInterface 的 static 方法
//postfix func - <T>(lhs: FluentInterface<T>) -> T {
//    return lhs.subject
//}

extension FluentInterface {
    func view() -> Subject {
        self.subject
    }
}

protocol Wrapper: UIView {}
extension Wrapper {
    func fluent() -> FluentInterface<Self> {
        FluentInterface(subject: self)
    }
}
extension UIView: Wrapper {}

let lbl = UILabel()
    .fluent()
    .frame(CGRect(x: 0, y: 0, width: 100, height: 100))
    .backgroundColor(.white)
    .alpha(0.5)
    .view()





//: [Next](@next) - [Table of Contents](Table_of_Contents)

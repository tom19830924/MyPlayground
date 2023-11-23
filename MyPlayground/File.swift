//
//  File.swift
//  MyPlayground
//
//  Created by user on 2023/11/20.
//

import Foundation
import UIKit

class MyClass {
    func render<E>(_ name: String, _ context: E) async -> String {
        print(type(of: context))
        return "HelloWorld"
    }
}

class Test {
    let myclass = MyClass()
    
    func test() async -> String{
        return await myclass.render("123", "123")
    }
}




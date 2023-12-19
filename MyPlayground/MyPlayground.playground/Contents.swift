import Foundation
import Combine
import UIKit
import SwiftUI

protocol Pizza {
    var size: Int { get }
    var name: String { get }
}
class Hawaiian: Pizza {
    var size: Int { 6 }
    var name: String { "Hawaiian" }
}

class Main {
//    func receivePizza(_ pizza: Pizza) {
//        print("Omnomnom, that's a nice \(pizza.name)")
//    }
    func receivePizza<T: Pizza>(_ pizza: T) {
        print("Omnomnom, that's a nice \(pizza.name)")
    }
}

var pizza = Hawaiian()

var main = Main()
main.receivePizza(pizza)

//var var1: View = Text("Sample Text")
var var2: some View = Text("Sample Text")
var var3: any View = Text("Sample Text")

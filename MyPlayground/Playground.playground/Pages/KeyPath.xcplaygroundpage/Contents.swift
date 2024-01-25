/*:
 # KeyPath
 */
/*:
 Key Path是一個類別, 基底類別為AnyKeyPath -> PartialKeyPath -> KeyPath -> WritableKeyPath -> ReferenceWritableKeyPath
 */
/*:
 ## Key Path Expression
 Key Path expressions have the following form:
 > \\`TypeName`.`path`
 */
/*:
    \String.count
*/

/*
 KeyPah可以隱式的轉換為closure, 可以將 \.name 丟入 closure, 不可明確的 let kayPath: KeyPath
(Root) -> Value
{ object in
    object[keyPath: keyPath]
}
 */

import Foundation
import UIKit

struct CellViewModel: BookInfoViewModel {
    var infoPath = \CellViewModel.bookInfo
    
    let bookInfo: String
    let books: [Book]
    init() {
        books = [Book(title: "The Adventures of Tom Sawyer", language: .English, author: Author(name: "Mark Twain")),
                 Book(title: "The Lord of the Rings", language: .English, author: Author(name: " J. R. R. Tolkien")),
                 Book(title: "The Adventures of Pinocchio", language: .Italian, author: Author(name: "Carlo Collodi")),
                 Book(title: "The Witcher", language: .Polish, author: Author(name: "Andrzej Sapkowski")),
                 Book(title: "War and Peace", language: .Russian, author: Author(name: "Leo Tolstoy")),
                 Book(title: "The Da Vinci Code", language: .English, author: Author(name: "Dan Brown")),
                 Book(title: "Angels & Demons", language: .English, author: Author(name: "Dan Brown")),
                 Book(title: "Inferno", language: .English, author: Author(name: "Dan Brown"))]
        
        bookInfo = "\(books.first!.title), \(books.first!.author.name)"
    }
}

protocol BookInfoViewModel {
    var infoPath: KeyPath<Self, String> { get }
}
class Cell {
    func configWtih<T: BookInfoViewModel>(_ bookInfo: T) {
        print(bookInfo[keyPath: bookInfo.infoPath], terminator: "\n\n")
    }
}

let cellViewModel = CellViewModel()
let cell = Cell()
cell.configWtih(cellViewModel)

extension Array {
    func filter<T: Equatable>(subject: T, on path: KeyPath<Element, T>) -> Self {
        filter {
            $0[keyPath: path] == subject
        }
    }
}

print(cellViewModel.books.filter(subject: .English, on: \.language), terminator: "\n\n")
print(cellViewModel.books.filter(subject: "Dan Brown", on: \.author.name), terminator: "\n\n")
//print(cellViewModel.books.filter(subject: "Andrzej Sapkowski", on: \.author.name))

//["1","2","3÷"].filter(language: .English, on: \.count)

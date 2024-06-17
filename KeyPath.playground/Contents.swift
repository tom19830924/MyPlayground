import UIKit

protocol 有名字 {
    // 這name其實不是很重要, 但這樣寫就限制使用的一定要有一個name屬性
//    var name: String { get }
    
    static var namePath: KeyPath<Self, String> { get }
}
extension 有名字 {
    func 打招呼() {
        print("哈囉 \( self[keyPath: Self.namePath] )")
    }
}

struct 貓咪: 有名字 {
    static var namePath: KeyPath<貓咪, String> = \貓咪.名字
    
    var 名字: String
}
struct 地址: 有名字 {
    let 住戶: String
    let 城市: String
    let 街道: String
    let 樓層: String
    
    static var namePath: KeyPath<Self, String> = \.住戶
}

var cat = 貓咪(名字: "蛋蛋")
let namePath = \貓咪.名字
cat[keyPath: \貓咪.名字]
cat[keyPath: namePath]
cat[keyPath: namePath] = "啾咪"

let cats = [
    貓咪(名字: "蛋蛋"),
    貓咪(名字: "啾咪"),
]

print(cats[keyPath: \[貓咪].[1].名字])


// KeyPath as function, 當一個參數型別是 (Root) -> Value 時, 可以使用 KeyPath
print(cats.map(\.名字))
print(cats.map(\.名字))



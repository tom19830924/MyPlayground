import UIKit

@globalActor
actor TradingActor {
    static let shared = TradingActor()
}

struct Stock {
    var id: String
    var 單價: Int
    var 股數: Int
    
    @TradingActor static func buy(_ stock: Stock, by buyer: 玩家) {
        buyer.money -= stock.單價 * stock.股數
    }
}
class 玩家 {
    var name: String
    @TradingActor var money: Int
    
    @TradingActor
    func give(_ other: 玩家, amount: Int) {
        self.money -= amount
        other.money += amount
        
        print(">> 交易後資產：\(name) \(money) 元；\(other.name) \(other.money) 元。")
    }
    
    init(name: String, money: Int) {
        self.name = name
        self.money = money
    }
}

let player = 玩家(name: "Jane", money: 100)
let cat = 玩家(name: "🐱", money: 0)
Task {
    await withTaskGroup(of: Void.self) { group in
        (0..<5000).forEach { _ in
            group.addTask {
                await player.give(cat, amount: 50)
            }
            group.addTask {
                await cat.give(player, amount: 50)
            }
        }
        
        await group.waitForAll()
        print("剩下的總金額：\((await player.money) + (await cat.money))")
    }
}

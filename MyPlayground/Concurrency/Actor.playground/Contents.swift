import UIKit

actor BankAccount {
    let name: String
    var balance = 1000
    
    init(_ name: String) { self.name = name }
    
    func withdraw(_ amount: Int) -> Int {
        if amount > balance {
            print("⚠️ \(name)存款只剩 \(balance) 元, 無法提款 \(amount) 元")
            return 0
        }
        balance -= amount
        print("🔽 \(name)提款 \(amount) 元, 剩下 \(balance) 元")
        return amount
    }
    
    func deposit(_ amount: Int) -> Int {
        balance += amount
        print("\(name)存款 \(amount) 元, 目前存款為 \(balance) 元")
        return balance
    }
    
    func printBalance() {
        print("\(name)餘額為: \(balance) 元")
    }
}

func syncAction(account: isolated BankAccount) {
    print("-------------------開始")
    account.withdraw(200)
    account.deposit(100)
    print("-------------------結束\n")
}

extension BankAccount: CustomStringConvertible, Hashable {
    nonisolated var description: String {
        name
    }
    
    static func == (lhs: BankAccount, rhs: BankAccount) -> Bool {
        lhs.name == rhs.name
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

let familyAccount = BankAccount("家庭帳戶")
print("創建了 \(familyAccount.name)。")

Task {
    print("一開始有：\(await familyAccount.balance) 元。\n")
    await withTaskGroup(of: Void.self) { group in
        (0...3).forEach { number in
            group.addTask {
                await syncAction(account: familyAccount)
            }
        }
        await group.waitForAll()
        await familyAccount.printBalance()
    }
}

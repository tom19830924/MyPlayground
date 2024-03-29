import UIKit

func goSleep() {
    sleep(1)
    print("睡飽了")
}

class Counter {
    func increase(n: Int) {
        print("\(n)")
    }
}

let counter = Counter()
for i in 1...30 {
    Task {
        counter.increase(n: i)
    }
}

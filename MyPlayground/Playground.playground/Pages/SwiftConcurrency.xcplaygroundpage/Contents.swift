//: [Previous](@previous)

import Foundation


//print("1")
//Task {
//    let result = try Data(contentsOf: url)
//    print(result)
//}
//print("2")

class Download {
    func getFile() async -> Data? {
        print("1.1 \(Thread.current)")
        let urlString = "http://speedtest.ftp.otenet.gr/files/test10Mb.db"
        let url = URL(string: urlString)!
        let data = try? Data(contentsOf: url)
        print("1.2 \(Thread.current)")
        return data
    }
    
    func getFile2() async -> Data? {
//        print("1.1 \(Thread.current)")
//        let urlString = "http://speedtest.ftp.otenet.gr/files/test10Mb.db"
//        let url = URL(string: urlString)!
//        let data = try? Data(contentsOf: url)
//        print("1.2 \(Thread.current)")
        
        let request = URLRequest(url: url)
        let result = await URLSession.shared.data(for: request)
        return result.0
    }
}

class Main {
    func run() {
        print("Start")
        print("1 \(Thread.current)")
        Task {
            print("2 \(Thread.current)")
            let data = await Download().getFile()
            print("3 \(Thread.current)")
            print(data ?? "")
        }
        print("4 \(Thread.current)")
        print("End")
    }
}

Main().run()
//: [Next](@next)

//
//  AsyncLetDemoView.swift
//  MyPlayground
//
//  Created by user on 2023/12/27.
//

import SwiftUI

struct AsyncLetDemoView {
    @State private var isLoading = false
    @State private var name: String = "匿名"
    @State private var image: String = "avatarPlaceholder"
    @State private var timeMessage = " "
    
    func fetchData() async {
        let startTime = Date.now
        name = await fetchUsername()
        image = await fetchImage()
        timeMessage = getElapsedTime(from: startTime)
    }
    
//    func fetchData() async {
//        let startTime = Date.now
//        Task { name = await fetchUsername() }
//        Task { image = await fetchImage() }
//        timeMessage = getElapsedTime(from: startTime)
//    }
    
//    func fetchData() async {
//        // 這邊會有個小問題, 兩個fetch是同時開始沒錯, 但這await是有順序關係
//        // 假設圖片先好沒辦法顯示, 因為前面的name還在等待結果
//        let startTime = Date.now
//        async let name = fetchUsername()
//        async let image = fetchImage()
//        print("1")
//        await self.name = name
//        print("2")
//        await self.image = image
//        print("3")
//        timeMessage = getElapsedTime(from: startTime)
//    }
    func fetchUsername() async -> String {
        try! await Task.sleep(for: .seconds(1))
        return "Tom"
    }
    func fetchImage() async -> String {
        try! await Task.sleep(for: .seconds(1))
        return "avatar"
    }
    
}
extension AsyncLetDemoView: View {
    var body: some View {
        VStack {
            Text(name)
            Image(image, bundle: nil)
            Text(timeMessage)
            Button("登入") {
                Task {
                    await fetchData()
                }
            }
        }
    }
    func getElapsedTime(from: Date) -> String {
        return String(format: "完成任務時間過過 %.6f 秒", Date.now.timeIntervalSince(from))
    }
}
#Preview {
    AsyncLetDemoView()
}

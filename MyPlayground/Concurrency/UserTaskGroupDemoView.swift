//
//  UserTaskGroupDemoView.swift
//  MyPlayground
//
//  Created by user on 2023/12/27.
//

import SwiftUI

enum APIError: Error {
    case 故意報錯
}

enum FetchUserManager {
    static func fetchUser(id: Int) async throws -> TaskGroupUser {
        try await Task.sleep()
        if id == 3 {
            throw APIError.故意報錯
        }
        let names = ["Ven", "Wayne", "Connor", "Weichen", "Laurence"]
        return TaskGroupUser(name: names[id - 1])
    }
    
    @Sendable static func fetch(userIDs: [Int]) async throws -> [TaskGroupUser] {
        try await withThrowingTaskGroup(of: (index: Int, user: TaskGroupUser?).self, returning: [TaskGroupUser].self) { group in
            for id in userIDs {
                group.addTask {
                    (id-1, try await fetchUser(id: id))
                }
            }
            
            var users = Array(repeating: TaskGroupUser?.none, count: userIDs.count)
            for try await result in group {
                users[result.index] = result.user
            }
            return users.compactMap { $0 }
        }
    }
}

struct UserTaskGroupDemoView: View {
    @State private var users = [TaskGroupUser]()
    @State private var timeMessage = "下載中"
        
    @Sendable func fetch() async {
        let startTime = Date.now
        let userIDs = Array(1...5)
        do {
            users = try await FetchUserManager.fetch(userIDs: userIDs)
            timeMessage = getElapsedTime(from: startTime)
        } catch {
            timeMessage = "發生錯誤: \(error)"
        }
    }
    @Sendable func reload() async {
        users = []
        timeMessage = "下載中"
        await fetch()
    }
    func getElapsedTime(from: Date) -> String {
        return String(format: "完成任務時間過過 %.6f 秒", Date.now.timeIntervalSince(from))
    }
}
extension UserTaskGroupDemoView {
    var body: some View {
        NavigationStack {
            Button("Fetch") {
                Task {
                    await reload()
                }
            }
            List(users) { user in
                HStack {
                    Text(user.name)
                        .font(.title2.weight(.medium))
                }
            }
            .navigationTitle(timeMessage)
            .navigationBarTitleDisplayMode(.inline)
            .refreshable(action: reload)
        }.task(fetch)
    }
}
struct TaskGroupUser: Identifiable {
    var name: String
    var id: String {
        name
    }
}
extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double = Double.random(in: 0.5...2.0)) async throws {
        try await Task.sleep(for: .seconds(seconds))
    }
}

#Preview {
    UserTaskGroupDemoView()
}

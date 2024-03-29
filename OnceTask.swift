import SwiftUI
import Combine

@available(iOS 13,*)
struct OnceTaskModifier: ViewModifier {
    var action: @Sendable () async -> Void
    var priority: TaskPriority
    @State private var currentTask: Task<Void, Never>?
    @State private var hasAppeared = false
    
    @inlinable public init(priority: TaskPriority, action: @escaping @Sendable () async -> Void) {
        self.priority = priority
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !hasAppeared {
                    currentTask = Task(priority: priority, operation: action)
                    hasAppeared = true
                }
            }
            .onDisappear() {
                currentTask?.cancel()
            }
    }
}

@available(iOS 14,*)
struct OnceTaskValueModifier<Value>: ViewModifier where Value: Equatable {
    var action: @Sendable () async -> Void
    var priority: TaskPriority
    var value: Value
    @State private var currentTask: Task<Void, Never>?
    @State private var hasAppeared = false
    
    public init(value: Value, priority: TaskPriority, action: @escaping @Sendable () async -> Void) {
        let _ = print("OnceTaskValueModifier init", value)
        self.action = action
        self.priority = priority
        self.value = value
    }
    
    func body(content: Content) -> some View {
        let _ = print("OnceTaskValueModifier body")
        content
            .onAppear {
                if !hasAppeared {
                    currentTask = Task(priority: priority, operation: action)
                    hasAppeared = true
                }
            }
            .onDisappear {
                currentTask?.cancel()
            }
            .onChange(of: value) { value in
                currentTask?.cancel()
                currentTask = Task(priority: priority, operation: action)
            }
    }
}

extension View {
    @available(iOS 13, *)
    func onceTask(priority: TaskPriority = .userInitiated, @_inheritActorContext _ action: @escaping @Sendable () async -> Void) -> some View {
        modifier(OnceTaskModifier(priority: priority, action: action))
    }
    
    @available(iOS 14, *)
    func onceTask<T>(id value: T, priority: TaskPriority = .userInitiated, @_inheritActorContext _ action: @escaping @Sendable () async -> Void) -> some View where T: Equatable {
        modifier(OnceTaskValueModifier(value: value, priority: priority, action: action))
    }
}

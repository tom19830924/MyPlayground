//
//  MVVMView.swift
//  MyPlayground
//
//  Created by user on 2023/12/26.
//

import SwiftUI
import Combine

struct SendMessageView: View {
    @ObservedObject var viewModel: SendMessageViewModel
    
    var body: some View {
        VStack {
//            Text("Your message:")
            
            TextEditor(text: $viewModel.message)
            
            Button(viewModel.buttonTitle) {
                viewModel.send()
            }
            .disabled(viewModel.isSendingDisabled)
            
            if let errorText = viewModel.errorText {
                Text(errorText).foregroundColor(.red)
            }
        }
    }
}

protocol MessageSender {
    func sendMessage(_ message: String) async throws
}

@MainActor
class SendMessageViewModel: ObservableObject {
    @Published var message = ""
    @Published private(set) var errorText: String?
    
    var buttonTitle: String { isSending ? "Sending..." : "Send" }
    var isSendingDisabled: Bool { isSending || message.isEmpty }
    
    private let sender: MessageSender
    private var isSending = false
    
    init(sender: MessageSender) {
        self.sender = sender
    }
    func send() {
        guard !message.isEmpty else { return }
        guard !isSending else { return }
        
        isSending = true
        errorText = nil
        
        Task {
            do {
                try await sender.sendMessage(message)
                message = ""
            } catch {
                errorText = error.localizedDescription
            }
            
            isSending = false
        }
    }
}


class MessageSenderMock: MessageSender {
    @Published private(set) var pendingMessageCount = 0
    private var pendingMessageContinuations = [CheckedContinuation<Void, Error>]()
    
    
    func sendMessage(_ message: String) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            pendingMessageContinuations.append(continuation)
            pendingMessageCount += 1
        }
    }
    
    
    func sendPendingMessages() {
        let continuations = pendingMessageContinuations
        pendingMessageContinuations = []
        pendingMessageCount = 0
        continuations.forEach { $0.resume() }
    }
    
    func triggerError(_ error: Error) {
        let continuations = pendingMessageContinuations
        pendingMessageContinuations = []
        pendingMessageCount = 0
        continuations.forEach { $0.resume(throwing: error) }
    }
}

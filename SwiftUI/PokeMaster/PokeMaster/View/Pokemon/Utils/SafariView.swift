//
//  SafariView.swift
//  PokeMaster
//
//  Created by user on 2024/3/4.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let onFinished: () -> Void
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView
        
        init(_ parent: SafariView) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.onFinished()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = SFSafariViewController(url: url)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


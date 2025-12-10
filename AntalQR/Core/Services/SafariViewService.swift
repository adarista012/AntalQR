//
//  SafariViewService.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/9/25.
//
import SwiftUI
import SafariServices

struct SafariLinkData: Identifiable {
    let id = UUID()
    let url: URL
}

struct SafariViewService: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        
        let safariVC = SFSafariViewController(url: url, configuration: config)
        
        return safariVC
        
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

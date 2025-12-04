//
//  ToastMessage.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import SwiftUI

enum ToastType {
    case success
    case error
    case info
    
    var iconName: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
    
    var themeColor: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .info:
            return .yellow
        }
    }
}


struct ToastMessage: Identifiable {
    let id = UUID()
    let textKey: LocalizedStringKey
    let type: ToastType
    
    
}

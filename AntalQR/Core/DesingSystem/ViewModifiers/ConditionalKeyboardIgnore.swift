//
//  ConditionalKeyboardIgnore.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import SwiftUI

struct ConditionalKeyboardIgnore: ViewModifier {
    let condition: Bool
    
    func body(content: Content) -> some View {
        if condition {
            content
                .ignoresSafeArea(.keyboard, edges: .bottom)
        } else {
            content
        }
    }
}

extension View {
    func ignoreKeyboardSafeArea(if condition: Bool) -> some View {
        modifier(ConditionalKeyboardIgnore(condition: condition))
    }
}

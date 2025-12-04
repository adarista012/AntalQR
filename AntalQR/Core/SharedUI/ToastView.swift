//
//  ToastView.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import SwiftUI

struct ToastView: View {
    let toast: ToastMessage
    
    var body: some View {
        VStack {
             Spacer()
             HStack {
                 Image(systemName: toast.type.iconName)
                     .foregroundColor(toast.type.themeColor)
                 Text(toast.textKey)
                     .bold()
             }
             .padding()
             .cornerRadius(CornerRadius.md)
             .glassEffect()

         }.frame(maxWidth: .infinity)
    }
}


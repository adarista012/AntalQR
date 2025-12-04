//
//  QrEditorViewModel.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import Foundation
import SwiftUI

@Observable
final class QREditorViewModel {
    
    var isSaving: Bool = false
    
    let qrSize: CGFloat = 1200
    
    var qrColor: Color = .purple
    var squareColor: Color = .blue
    
    var qrMessage: String = ""
    
    let radiusOptions: [CornerRadiusOption] = CornerRadiusOption.allCases
        
    var selectedRadiusOption: CornerRadiusOption = .xl
        
    var squareCornerRadius: CGFloat { selectedRadiusOption.value }
    
    var gradientColors: [Color] { [qrColor.opacity(0.2), squareColor.opacity(0.2)] }
    
    func renderFinalQRImage() -> UIImage? {
        let content = ZStack {
            Color(squareColor).cornerRadius(squareCornerRadius)
            
            QRView(message: qrMessage, color: qrColor)
            
        }.frame(width: qrSize, height: qrSize)
        
        let renderer = ImageRenderer(content: content)
        renderer.proposedSize = .init(width: qrSize, height: qrSize)
        
        return renderer.uiImage
    }
    
}

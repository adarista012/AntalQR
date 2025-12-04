//
//  QROptions.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//

import SwiftUI


enum CornerRadiusOption: CaseIterable, Identifiable {
    case sm, md, lg, xl, xxl

    var id: Self { self }
    
    var value: CGFloat {
        switch self {
        case .sm: return CornerRadius.sm
        case .md: return CornerRadius.md
        case .lg: return CornerRadius.lg
        case .xl: return CornerRadius.xl
        case .xxl: return CornerRadius.xxl
        }
    }
    
    var label: String {
        switch self {
        case .sm: return "Sm"
        case .md: return "Md"
        case .lg: return "Lg"
        case .xl: return "XL"
        case .xxl: return "XXL"
        }
    }
}

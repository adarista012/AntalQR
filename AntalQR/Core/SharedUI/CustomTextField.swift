//
//  CustomTextField.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
// ⚙️ Core/SharedUI/CustomTextField.swift

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    
    let isFocused: FocusState<Bool>.Binding
    
    var submitAction: (() -> Void)? = nil
    
    var body: some View {
        TextField("inputPlaceholder", text: $text)
            .disableAutocorrection(true)
            .padding()
            .glassEffect(.clear.interactive())
            .focused(isFocused)
            .submitLabel(.done)
            .onSubmit { submitAction?() }
    }
}

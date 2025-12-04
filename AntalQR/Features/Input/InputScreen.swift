//
//  InputScreen.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import SwiftUI


struct InputScreen: View {
    @Bindable var viewModel: InputViewModel
    
    @FocusState.Binding var isKeyboardShowing: Bool
    
    let onInputSubmitted: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            infoButton
            
            Spacer()
            
            
            Text("welcomeTitle").font(.largeTitle).bold()
            
            Text("welcomeSubtitle").font(.subheadline)
            
            Spacer()
            
            CustomTextField(
                text: $viewModel.inputText,
                isFocused: $isKeyboardShowing,
                submitAction: { onInputSubmitted(viewModel.inputText) }
            )
            
        }
    }
}

private var infoButton: some View {
    NavigationLink(destination: AboutScreen(), label: {Label("", systemImage: "info")}).padding().labelStyle(.iconOnly).foregroundStyle(.primary).glassEffect(.clear.interactive()).clipShape(.circle).frame(maxWidth: .infinity, alignment: .trailing)
}


private struct InputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.disableAutocorrection(true).padding().glassEffect(.clear.interactive())
        
    }
}

extension View {
    func textInputStyle() -> some View {
        modifier(InputFieldModifier())
    }
}

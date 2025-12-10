//
//  MainView.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 11/23/25.
//

import SwiftUI


struct MainView: View {
    @FocusState private var isKeyboardShowing: Bool
    
    @State private var viewModel = MainViewModel()
    
    @ViewBuilder private var currentScreen: some View {
        if viewModel.submittedText == nil || viewModel.submittedText!.isEmpty {
            InputScreen(
                viewModel: viewModel.inputVM,
                isKeyboardShowing: $isKeyboardShowing,
                onInputSubmitted: viewModel.handleSubmitInput()
            )
            
        } else {
            QREditorScreen(
                viewModel: viewModel.editorVM,
                isKeyboardShowing: $isKeyboardShowing,
                onSaveImage: viewModel.handleOnSaveImage()
            )
        }
        
    }
    
    var body: some View {
        VStack {
            currentScreen
            
            if viewModel.isShowingToast, let toast = viewModel.toast {
                ToastView(toast: toast)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.bouncy, value: viewModel.isShowingToast)
                
            }
            
        }.viewBackground(backgroundColors: viewModel.currentBackgroundColor, submittedText: viewModel.submittedText)
            .animation(.easeInOut, value: viewModel.submittedText)
            .onTapGesture {
                if isKeyboardShowing {
                    isKeyboardShowing = false
                }
            }
            
    }
}

private struct BackgroundModifier: ViewModifier {
    let backgroundColors: [Color]
    let submittedText: String?
    
    func body(content: Content) -> some View {
        content.padding().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).background(LinearGradient(colors: backgroundColors, startPoint: .topLeading,endPoint: .bottomTrailing).ignoresSafeArea()).ignoreKeyboardSafeArea(if: submittedText != nil)
    }
}


extension View {
    func viewBackground(backgroundColors: [Color], submittedText: String?) -> some View {
        modifier(BackgroundModifier(backgroundColors: backgroundColors, submittedText: submittedText))
    }
    
}


#Preview{
    MainView()
}

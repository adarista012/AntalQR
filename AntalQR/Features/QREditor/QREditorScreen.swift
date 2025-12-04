//
//  QREditorScreen.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import SwiftUI

struct QREditorScreen: View {
    @Bindable var viewModel: QREditorViewModel
    
    @FocusState.Binding var isKeyboardShowing: Bool
    
    @State private var qrSize: CGFloat = 0
    
    let onSaveImage: (UIImage) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            qrDisplay
            
            CustomTextField(text: $viewModel.qrMessage, isFocused: $isKeyboardShowing)
            
            Divider()
            
            Text("editYourQr").font(.title3)
            
            cornerRadiusPicker
            
            colorPickers
            
            Spacer()
            
            saveButton
            
        }
    }
    
    private var qrDisplay: some View {
        Color(viewModel.squareColor).containerRelativeFrame(.horizontal){length, _ in
            let size = length - Spacing.xl
            
            DispatchQueue.main.async {
                qrSize = size
                
            }
            
            return size
        }.frame(minHeight: Sizes.medium).aspectRatio(1.0, contentMode: .fit).cornerRadius(viewModel.squareCornerRadius).overlay{
            QRView(message: viewModel.qrMessage, color: viewModel.qrColor).padding(.vertical)
            
        }
    }
    
    private var cornerRadiusPicker: some View {
        Group {
            Label {
              Text("cornerRadius")
            } icon: {
                 Color(viewModel.squareColor)
                 .frame(width: Spacing.md, height: Spacing.md)
                 .cornerRadius(viewModel.squareCornerRadius / Spacing.sm)
            }
            
            Picker("", selection: $viewModel.selectedRadiusOption) {
                ForEach(viewModel.radiusOptions) { option in
                            Text(option.label)
                                .tag(option)
                }
            }
            .pickerStyle(.segmented).labelsHidden()
        }
        
    }
    
    private var colorPickers: some View {
        Group {
            ColorPicker(selection: $viewModel.squareColor, label: {
                Label {
                       Text("squareColor")
                } icon: {
                        Image(systemName: "square.fill")
                        .foregroundColor(viewModel.squareColor)
                 }
            })
            
            ColorPicker(selection: $viewModel.qrColor, label: {
                Label {
                       Text("qrColor")
                } icon: {
                        Image(systemName: "qrcode")
                        .foregroundColor(viewModel.qrColor)
                  }
            })
        }
    }
    
    private var saveButton: some View {
        Button("saveQR"){
            guard qrSize > 0, let image = viewModel.renderFinalQRImage() else {
                return
                
            }
            
            onSaveImage(image)
            
        }.buttonStyle(.glass).frame(maxWidth: .infinity, alignment: .center).disabled(viewModel.isSaving)
    }
}


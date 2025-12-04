//
//  MainViewModel.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//

import Foundation
import SwiftUI

@Observable
final class MainViewModel {
    let inputVM = InputViewModel()
    let editorVM = QREditorViewModel()
    
    let hapticService = HapticService()
    let photoService = PhotoLibraryService()
    
    var isShowingToast: Bool = false
    
    var submittedText: String? = nil
    
    var toast: ToastMessage? = nil
    
    var currentBackgroundColor: [Color] { editorVM.gradientColors }
    
    func showToastMessage(_ textKey: LocalizedStringKey, type: ToastType){
        Task{@MainActor in
            
            withAnimation(.easeInOut) { isShowingToast = false }
            
            try? await Task.sleep(for: .milliseconds(50))
            
            toast = ToastMessage(textKey: textKey, type: type)
            
            withAnimation(.spring()) { isShowingToast = true }
            
            try? await Task.sleep(for: .seconds(2))
            
            withAnimation(.easeInOut) { isShowingToast = false }
            
            toast = nil
            
        }
        
    }
    
    func handleSubmitInput() -> (String) -> Void {
        return {
            [weak self] rawText in
                    guard let self = self else { return }
            
            let trimmed = inputVM.inputText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard !trimmed.isEmpty else { return }
            
            self.submittedText = trimmed
            
            editorVM.qrMessage = trimmed
        }
    }
    
    func saveImage(image: UIImage) {
        editorVM.isSaving = true
        
        Task {@MainActor in
            
            let result = await photoService.saveImageToPhotos(image)
            
            switch result {
            case .success:
                hapticService.playSuccess()
                showToastMessage("savedToGallery", type: .success)
            case .error:
                hapticService.playError()
                showToastMessage("errorToSave", type: .error)
            case .needsSettings:
                hapticService.playWarning()
                showToastMessage("needsSettingsInstructions", type: .info)
            }
            
            editorVM.isSaving = false
            
        }
        
        
    }
    
    func handleOnSaveImage() -> (UIImage) -> Void {
        return { [weak self] imageToSave in
            
            guard let self = self else { return }
            
            self.saveImage(image: imageToSave)
        }
    }
    
}

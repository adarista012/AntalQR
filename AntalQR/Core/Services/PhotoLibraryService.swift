//
//  PhotoLibraryService.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import Foundation
import UIKit
import Photos

enum SaveResult {
    case success
    case needsSettings
    case error
}

final class PhotoLibraryService {
    func saveImageToPhotos(_ image: UIImage) async -> SaveResult {
        
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        switch status {
        case .authorized, .limited:
           
            return await performSave(image)
            
        case .notDetermined:
           
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
            if newStatus == .authorized || newStatus == .limited {
                return await performSave(image)
            } else {
                return .error
            }
            
        case .denied, .restricted:
            
            return .needsSettings
            
        @unknown default:
            return .error
        }
    }

    private func performSave(_ image: UIImage) async -> SaveResult {
        await withCheckedContinuation { continuation in
            PHPhotoLibrary.shared().performChanges({

                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: { success, error in
                
                if success {
                    continuation.resume(returning: .success)
                } else {
                    continuation.resume(returning: .error)
                }
            })
        }
    }
}

//
//  HapticService.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//
import Foundation
import SwiftUI

final class HapticService {
    private let notificationGenerator = UINotificationFeedbackGenerator()
    
    init() {
        notificationGenerator.prepare()
            
    }
    
    func playSuccess(){
        notificationGenerator.notificationOccurred(.success)
        
    }
    
    func playError(){
        notificationGenerator.notificationOccurred(.error)
        
    }
    
    func playWarning(){
        notificationGenerator.notificationOccurred(.warning)
        
    }
}

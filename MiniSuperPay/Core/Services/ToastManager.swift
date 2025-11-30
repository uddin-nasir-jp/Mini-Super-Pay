//
//  ToastManager.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

@Observable
final class ToastManager {
    var showToast = false
    var toastMessage = ""
    var toastType: SPToastType = .success
    
    func show(_ message: String, type: SPToastType = .success) {
        toastMessage = message
        toastType = type
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

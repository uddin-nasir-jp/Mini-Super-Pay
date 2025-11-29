//
//  View+Extensions.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 28/11/25.
//

import SwiftUI

extension View {
    // PLAN: For further usages
    func loadingOverlay(isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                .ignoresSafeArea()
            }
        }
    }
}

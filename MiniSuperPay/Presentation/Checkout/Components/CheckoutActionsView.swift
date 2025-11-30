//
//  CheckoutActionsView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

// MARK: - Checkout operation control view
struct CheckoutActionsView: View {
    // MARK: - PROPERTIES
    let canProceed: Bool
    let onCheckout: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: DesignConstants.smallSpacing) {
            Button {
                onCheckout()
            } label: {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: DesignConstants.baseFont))
                    SPTextView(
                        text: "Complete Purchase",
                        size: DesignConstants.baseFont,
                        weight: .bold,
                        textColor: .white
                    )
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(canProceed ? Color.colorPrimary : Color.gray)
                .cornerRadius(DesignConstants.mediumRadius)
            }
            .disabled(!canProceed)
            
            Button {
                onCancel()
            } label: {
                SPTextView(
                    text: "Cancel",
                    size: DesignConstants.smFont,
                    textColor: .errorColor
                )
            }
        }
    }
}

#Preview {
    CheckoutActionsView(
        canProceed: true,
        onCheckout: { print("Checkout") },
        onCancel: { print("Cancel") }
    )
    .padding()
}

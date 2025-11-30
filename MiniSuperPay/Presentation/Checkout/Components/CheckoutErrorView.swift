//
//  CheckoutErrorView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct CheckoutErrorView: View {
    // MARK: - PROPERTIES
    let errorMessage: String?
    let onRetry: () -> Void
    let onBackToCart: () -> Void
    
    var body: some View {
        VStack(spacing: DesignConstants.largeSpacing) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.red)
            
            SPTextView(
                text: "Payment Failed",
                size: DesignConstants.lgFont,
                weight: .bold,
                textColor: .textColor,
                alignment: .center
            )
            
            if let message = errorMessage {
                SPTextView(
                    text: message,
                    size: DesignConstants.baseFont,
                    textColor: .textColorLight,
                    alignment: .center
                )
            }
            
            VStack(spacing: DesignConstants.smallSpacing) {
                Button {
                    onRetry()
                } label: {
                    SPTextView(
                        text: "Try Again",
                        size: DesignConstants.baseFont,
                        weight: .semibold,
                        textColor: .white,
                        alignment: .center
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(DesignConstants.mediumRadius)
                }
                
                Button {
                    onBackToCart()
                } label: {
                    SPTextView(
                        text: "Back to Cart",
                        size: DesignConstants.smFont,
                        textColor: .themePrimary
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    CheckoutErrorView(
        errorMessage: "Insufficient funds in wallet",
        onRetry: { print("Retry") },
        onBackToCart: { print("Back to Cart") }
    )
}

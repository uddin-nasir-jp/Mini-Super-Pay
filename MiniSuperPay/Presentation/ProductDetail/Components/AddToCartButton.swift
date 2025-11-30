//
//  AddToCartButton.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct AddToCartButton: View {
    let isInCart: Bool
    let onAddToCart: () -> Void
    
    var body: some View {
        Button(action: onAddToCart) {
            HStack(spacing: DesignConstants.smallSpacing) {
                Image(systemName: isInCart ? "checkmark.circle.fill" : "cart.badge.plus")
                    .font(.system(size: DesignConstants.lgFont, weight: .semibold))
                
                SPTextView(
                    text: isInCart ? .productAlreadyInCart : .productAddToCart,
                    size: DesignConstants.lgFont,
                    weight: .bold,
                    textColor: .white
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignConstants.mediumSpacing)
            .background(
                LinearGradient(
                    colors: isInCart 
                        ? [Color.gray, Color.gray.opacity(0.8)]
                        : [Color.colorPrimary, Color.colorPrimary.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(DesignConstants.mediumRadius)
            .shadow(color: isInCart ? Color.clear : Color.colorPrimary.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
        .disabled(isInCart)
    }
}

#Preview("Not in Cart") {
    AddToCartButton(isInCart: false, onAddToCart: { print("Add to cart") })
        .padding()
}

#Preview("Already in Cart") {
    AddToCartButton(isInCart: true, onAddToCart: { print("Add to cart") })
        .padding()
}

//
//  CheckoutSuccessView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct CheckoutSuccessView: View {
    // MARK: - PROPERTIES
    let successMessage: String?
    let amountPaid: String
    let newBalance: String
    let onContinueShopping: () -> Void
    
    var body: some View {
        VStack(spacing: DesignConstants.largeSpacing) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)
            
            CustomTextView(
                text: "Payment Successful!",
                size: DesignConstants.lgFont,
                weight: .bold,
                textColor: .textColor,
                alignment: .center
            )
            
            if let message = successMessage {
                CustomTextView(
                    text: message,
                    size: DesignConstants.baseFont,
                    textColor: .textColorLight,
                    alignment: .center
                )
            }
            
            VStack(alignment: .leading, spacing: DesignConstants.smallSpacing) {
                HStack {
                    CustomTextView(
                        text: "Amount Paid:",
                        size: DesignConstants.baseFont,
                        textColor: .textColor
                    )
                    Spacer()
                    CustomTextView(
                        text: amountPaid,
                        size: DesignConstants.baseFont,
                        weight: .bold,
                        textColor: .textColor
                    )
                }
                
                HStack {
                    CustomTextView(
                        text: "New Wallet Balance:",
                        size: DesignConstants.baseFont,
                        textColor: .textColor
                    )
                    Spacer()
                    CustomTextView(
                        text: newBalance,
                        size: DesignConstants.baseFont,
                        weight: .bold,
                        textColor: .successColor
                    )
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(DesignConstants.mediumRadius)
            
            Button {
                onContinueShopping()
            } label: {
                CustomTextView(
                    text: "Continue Shopping",
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
        }
        .padding()
    }
}

#Preview {
    CheckoutSuccessView(
        successMessage: "Your order has been placed successfully",
        amountPaid: "$209.97",
        newBalance: "$790.03",
        onContinueShopping: { print("Continue Shopping") }
    )
}

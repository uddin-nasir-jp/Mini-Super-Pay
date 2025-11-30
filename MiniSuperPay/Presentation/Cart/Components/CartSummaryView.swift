//
//  CartSummaryView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: - Cart summary view
struct CartSummaryView: View {
    // MARK: - PROPERTIES
    let itemCount: Int
    let totalPrice: Double
    
    var body: some View {
        VStack(spacing: DesignConstants.smallSpacing) {
            HStack {
                SPTextView(
                    text: "Items Qty",
                    size: DesignConstants.baseFont,
                    textColor: .textColorLight
                )
                Spacer()
                SPTextView(
                    text: "\(itemCount)",
                    size: DesignConstants.baseFont,
                    weight: .bold,
                    textColor: .textColor
                )
            }
            
            Divider()
            
            HStack {
                SPTextView(
                    text: "Total Price",
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColor
                )
                Spacer()
                SPTextView(
                    text: totalPrice.asFormattedCurrency,
                    size: DesignConstants.xlFont,
                    weight: .bold,
                    textColor: .successColor
                )
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(DesignConstants.mediumRadius)
    }
}

#Preview {
    CartSummaryView(itemCount: 5, totalPrice: 25.99)
        .padding()
}

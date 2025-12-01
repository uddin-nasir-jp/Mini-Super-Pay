//
//  OrderSummaryView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct OrderSummaryView: View {
    // MARK: - PROPERTIES
    let items: [CartItem]
    let total: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.mediumSpacing) {
            SPTextView(
                text: .checkoutOrderSummary,
                size: DesignConstants.baseFont,
                weight: .semibold,
                textColor: .textColor
            )
            
            ForEach(items) { item in
                HStack(spacing: DesignConstants.mediumSpacing) {
                    SPAsyncImageView(
                        imageURL: item.product.imageURL ?? "",
                        width: 50,
                        height: 50,
                        cornerRadius: DesignConstants.smallRadius,
                        contentMode: .fill
                    )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        SPTextView(
                            text: item.product.name,
                            size: DesignConstants.smFont,
                            weight: .medium,
                            textColor: .textColor
                        )
                        .lineLimit(1)
                        
                        SPTextView(
                            text: .cartQuantity(item.quantity),
                            size: DesignConstants.xsFont,
                            textColor: .textColorLight
                        )
                    }
                    
                    Spacer()
                    
                    SPTextView(
                        text: item.formattedTotalPrice,
                        size: DesignConstants.smFont,
                        weight: .bold,
                        textColor: .successColor
                    )
                }
                .padding(.vertical, 4)
            }
            
            Divider()
            
            HStack {
                SPTextView(
                    text: .cartTotal,
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColor
                )
                
                Spacer()
                
                SPTextView(
                    text: total.asFormattedCurrency,
                    size: DesignConstants.lgFont,
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
    OrderSummaryView(items: CartItem.mockCartItems, total: 15.96)
        .padding()
}

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
                text: "Order Summary",
                size: DesignConstants.baseFont,
                weight: .semibold,
                textColor: .textColor
            )
            
            ForEach(items) { item in
                HStack {
                    SPTextView(
                        text: "\(item.quantity)x",
                        size: DesignConstants.smFont,
                        textColor: .textColorLight
                    )
                    
                    SPTextView(
                        text: item.product.name,
                        size: DesignConstants.smFont,
                        textColor: .textColor
                    )
                    
                    Spacer()
                    
                    SPTextView(
                        text: item.formattedTotalPrice,
                        size: DesignConstants.smFont,
                        weight: .bold,
                        textColor: .textColor
                    )
                }
            }
            
            Divider()
            
            HStack {
                SPTextView(
                    text: "Total",
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

//
//  ProductPriceCard.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct ProductPriceCard: View {
    let price: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                SPTextView(
                    text: .productPrice,
                    size: DesignConstants.smFont,
                    textColor: .textColorLight
                )
                
                SPTextView(
                    text: price,
                    size: DesignConstants.doubleXlFont,
                    weight: .bold,
                    textColor: .successColor
                )
            }
            
            Spacer()
            
            Image(systemName: "tag.fill")
                .font(.system(size: 40))
                .foregroundStyle(Color.successColor.opacity(0.2))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(DesignConstants.mediumRadius)
    }
}

#Preview {
    ProductPriceCard(price: "$99.99")
        .padding()
}

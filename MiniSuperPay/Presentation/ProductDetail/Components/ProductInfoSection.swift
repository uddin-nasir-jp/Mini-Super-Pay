//
//  ProductInfoSection.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct ProductInfoSection: View {
    let name: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.mediumSpacing) {
            SPTextView(
                text: name,
                size: DesignConstants.doubleXlFont,
                weight: .bold,
                textColor: .textColor
            )
            .lineLimit(2)
            
            SPTextView(
                text: description,
                size: DesignConstants.baseFont,
                textColor: .textColorLight
            )
            .lineLimit(4)
        }
    }
}

#Preview {
    ProductInfoSection(
        name: "Wireless Headphones",
        description: "Premium noise-cancelling wireless headphones with superior sound quality and long battery life."
    )
    .padding()
}

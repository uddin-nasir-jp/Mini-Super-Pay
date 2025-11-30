//
//  ProductCategoryBadge.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct ProductCategoryBadge: View {
    let category: String
    
    var body: some View {
        SPTextView(
            text: category.uppercased(),
            size: DesignConstants.xsFont,
            weight: .semibold,
            textColor: .colorPrimary
        )
        .padding(.horizontal, DesignConstants.mediumSpacing)
        .padding(.vertical, DesignConstants.extraSmallSpacing)
        .background(
            Capsule()
                .fill(Color.colorPrimary.opacity(0.1))
        )
        .overlay(
            Capsule()
                .stroke(Color.colorPrimary.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    ProductCategoryBadge(category: "Electronics")
        .padding()
}

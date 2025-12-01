//
//  ProductRowView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct ProductListItemView: View {
    let product: Product
    let isInCart: Bool
    let onAddToCart: () -> Void
    
    var body: some View {
        HStack(spacing: DesignConstants.mediumSpacing) {
            SPAsyncImageView(
                imageURL: product.imageURL ?? "",
                width: 80,
                height: 80,
                cornerRadius: DesignConstants.mediumRadius,
                contentMode: .fill
            )
            
            VStack(alignment: .leading, spacing: DesignConstants.smallSpacing) {
                SPTextView(
                    text: product.name,
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColor
                )
                .lineLimit(1)
                
                SPTextView(
                    text: product.description,
                    size: DesignConstants.xsFont,
                    textColor: .textColorLight
                )
                .lineLimit(2)
                
                SPTextView(
                    text: product.category,
                    size: DesignConstants.doubleXSFont,
                    weight: .medium,
                    textColor: Color.colorPrimary
                )
                .padding(.horizontal, DesignConstants.smallSpacing)
                .padding(.vertical, 2)
                .background(Color.colorPrimary.opacity(0.1))
                .cornerRadius(4)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: DesignConstants.smallSpacing) {
                SPTextView(
                    text: product.formattedPrice,
                    size: DesignConstants.baseFont,
                    weight: .bold,
                    textColor: .successColor
                )
                
                Button {
                    onAddToCart()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: isInCart ? "checkmark.circle.fill" : "cart.badge.plus")
                            .font(.system(size: DesignConstants.xsFont))
                        SPTextView(
                            text: isInCart ? .productAdded : .productAdd,
                            size: DesignConstants.xsFont,
                            weight: .bold,
                            textColor: .white
                        )
                    }
                    .padding(.horizontal, DesignConstants.smallSpacing)
                    .padding(.vertical, 6)
                    .background(isInCart ? Color.disabledBackgroundColor : Color.colorPrimary)
                    .foregroundStyle(.white)
                    .cornerRadius(DesignConstants.smallRadius)
                }
                .buttonStyle(.plain)
                .disabled(isInCart)
            }
        }
        .padding(.vertical, DesignConstants.extraSmallSpacing)
    }
}

#Preview {
    List {
        ProductListItemView(
            product: .mockProduct,
            isInCart: false,
            onAddToCart: {
                print("Added to cart")
            }
        )
        
        ProductListItemView(
            product: .mockProduct,
            isInCart: true,
            onAddToCart: {
                print("Already in cart")
            }
        )
    }
}

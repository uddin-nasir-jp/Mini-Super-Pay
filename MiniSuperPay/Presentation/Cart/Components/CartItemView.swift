//
//  CartItemRowView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct CartItemView: View {
    // MARK: - PROPERTIES
    let cartItem: CartItem
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: DesignConstants.mediumSpacing) {
            Image(systemName: "photo")
                .font(.system(size: DesignConstants.largeIcon))
                .foregroundStyle(.secondary)
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(DesignConstants.smallRadius)
            
            VStack(alignment: .leading, spacing: DesignConstants.extraSmallSpacing) {
                SPTextView(
                    text: cartItem.product.name,
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColor
                )
                .lineLimit(1)
                
                SPTextView(
                    text: .cartQuantity(cartItem.quantity),
                    size: DesignConstants.smFont,
                    textColor: .textColor
                )
                
                SPTextView(
                    text: cartItem.formattedTotalPrice,
                    size: DesignConstants.smFont,
                    weight: .bold,
                    textColor: .successColor
                )
            }
            
            Spacer()
            
            /// Quantity controls button
            HStack(spacing: DesignConstants.extraSmallSpacing) {
                Button {
                    onDecrement()
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                }
                .buttonStyle(.plain)
                .disabled(cartItem.quantity <= AppConstants.minimumCartQuantity)
                .opacity(cartItem.quantity <= AppConstants.minimumCartQuantity ? 0.6 : 1.0)
                //TODO: Use enable/disable opacity constants
                
                SPTextView(
                    text: "\(cartItem.quantity)",
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColorLight
                )
                .frame(minWidth: 30)
                
                Button {
                    onIncrement()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                }
                .buttonStyle(.plain)
                .disabled(cartItem.quantity >= AppConstants.maximumCartQuantity)
                .opacity(cartItem.quantity >= AppConstants.maximumCartQuantity ? 0.3 : 1.0) //TODO: Use enable/disable opacity constants
            }
        }
        .padding(.vertical, DesignConstants.extraSmallSpacing)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                onRemove()
            } label: {
                Label(String.actionDelete, systemImage: "trash")
            }
        }
    }
}

#Preview {
    List {
        CartItemView(
            cartItem: .mockCartItem,
            onIncrement: {},
            onDecrement: {},
            onRemove: {}
        )
    }
}

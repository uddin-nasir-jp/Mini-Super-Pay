//
//  EmptyStateView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    init(
        icon: String,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: DesignConstants.largeSpacing) {
            Image(systemName: icon)
                .font(.system(size: DesignConstants.extraLargeIcon + 20))
                .foregroundStyle(.secondary)
            
            CustomTextView(
                text: title,
                size: DesignConstants.xlFont,
                weight: .bold,
                textColor: .textColor,
                alignment: .center
            )
            
            CustomTextView(
                text: message,
                size: DesignConstants.baseFont,
                textColor: .textColorLight,
                alignment: .center
            )
            .padding(.horizontal, DesignConstants.largeSpacing)
            
            if let actionTitle, let action {
                Button(action: action) {
                    CustomTextView(
                        text: actionTitle,
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
                .padding(.horizontal, DesignConstants.largeSpacing)
                .padding(.top, DesignConstants.smallSpacing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        icon: "cart",
        title: "Your Cart is Empty",
        message: "Add some items to get started",
        actionTitle: "Start Shopping",
        action: { print("Action tapped") }
    )
}

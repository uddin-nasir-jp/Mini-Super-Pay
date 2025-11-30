//
//  WalletBalanceView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

// MARK: - Wallet balance view
struct WalletBalanceView: View {
    // MARK: - PROPERTIES
    let wallet: Wallet
    let requiredAmount: Double
    
    private var hasSufficientFunds: Bool {
        wallet.hasSufficientFunds(for: requiredAmount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignConstants.mediumSpacing) {
            HStack {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: DesignConstants.baseFont))
                    .foregroundStyle(.blue)
                SPTextView(
                    text: "Wallet Balance",
                    size: DesignConstants.baseFont,
                    weight: .semibold,
                    textColor: .textColor
                )
            }
            
            HStack {
                SPTextView(
                    text: "Available:",
                    size: DesignConstants.baseFont,
                    textColor: .textColorLight
                )
                
                Spacer()
                
                SPTextView(
                    text: wallet.formattedBalance,
                    size: DesignConstants.lgFont,
                    weight: .bold,
                    textColor: hasSufficientFunds ? .successColor : .errorColor
                )
            }
            
            if !hasSufficientFunds {
                HStack(spacing: DesignConstants.smallSpacing) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: DesignConstants.xsFont))
                        .foregroundStyle(.red)
                    SPTextView(
                        text: "Insufficient funds. Please add money to your wallet.",
                        size: DesignConstants.xsFont,
                        textColor: .errorColor
                    )
                }
                .padding(.top, DesignConstants.extraSmallSpacing)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(DesignConstants.mediumRadius)
    }
}

#Preview {
    VStack(spacing: 16) {
        WalletBalanceView(wallet: Wallet(balance: 100), requiredAmount: 25.99)
        WalletBalanceView(wallet: Wallet(balance: 10), requiredAmount: 25.99)
    }
    .padding()
}

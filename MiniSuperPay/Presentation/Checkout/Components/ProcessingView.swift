//
//  ProcessingView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct ProcessingView: View {
    // MARK: - PROPERTIES
    var body: some View {
        VStack(spacing: DesignConstants.largeSpacing) {
            ProgressView()
                .scaleEffect(2.0)
            
            SPTextView(
                text: "Processing Payment...",
                size: DesignConstants.lgFont,
                weight: .bold,
                textColor: .textColor,
                alignment: .center
            )
            
            SPTextView(
                text: "Please wait while we process your order",
                size: DesignConstants.smFont,
                textColor: .textColorLight,
                alignment: .center
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ProcessingView()
}

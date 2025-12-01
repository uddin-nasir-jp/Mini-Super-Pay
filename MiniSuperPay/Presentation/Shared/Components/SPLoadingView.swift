//
//  LoadingView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct SPLoadingView: View {
    var message: String = "Loading..."
    
    var body: some View {
        VStack(spacing: DesignConstants.mediumSpacing) {
            ProgressView()
                .scaleEffect(1.5)
            
            SPTextView(
                text: message,
                size: DesignConstants.smFont,
                textColor: .textColor,
                alignment: .center
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SPLoadingView()
}

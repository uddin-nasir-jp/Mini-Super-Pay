//
//  LoadingView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct LoadingView: View {
    var message: String = "Loading..."
    
    var body: some View {
        VStack(spacing: DesignConstants.mediumSpacing) {
            ProgressView()
                .scaleEffect(1.5)
            
            CustomTextView(
                text: message,
                size: DesignConstants.smFont,
                textColor: .textColorLight,
                alignment: .center
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}

//
//  ErrorView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 29/11/25.
//

import SwiftUI

struct SPErrorView: View {
    let error: Error
    let retryAction: () async -> Void
    
    var body: some View {
        VStack(spacing: DesignConstants.largeSpacing) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: DesignConstants.extraLargeIcon))
                .foregroundStyle(.red)
            
            SPTextView(
                text: .errorOops,
                size: DesignConstants.xlFont,
                weight: .bold,
                textColor: .textColor,
                alignment: .center
            )
            
            SPTextView(
                text: error.localizedDescription,
                size: DesignConstants.baseFont,
                textColor: .textColorLight,
                alignment: .center
            )
            .padding(.horizontal)
            
            Button {
                Task {
                    await retryAction()
                }
            } label: {
                SPTextView(
                    text: .errorTryAgain,
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    SPErrorView(error: NetworkError.unknownError) {
        print("Retry tapped")
    }
}

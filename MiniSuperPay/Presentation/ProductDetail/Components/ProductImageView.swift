//
//  ProductImageView.swift
//  MiniSuperPay
//
//  Created by Nasir Uddin on 30/11/25.
//

import SwiftUI

struct ProductImageView: View {
    let imageURL: String
    
    var body: some View {
        VStack {
            SPAsyncImageView(
                imageURL: imageURL,
                height: 280,
                cornerRadius: DesignConstants.largeRadius,
                contentMode: .fit
            )
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        }.frame(minHeight: 280)
    }
}

#Preview {
    ProductImageView(imageURL: "https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=800&q=80")
        .padding()
}
